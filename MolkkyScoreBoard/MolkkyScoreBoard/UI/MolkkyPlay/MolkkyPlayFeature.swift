//
//  MolkkyPlayFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/02.
//

import ComposableArchitecture

/// プレイ画面 Feature
struct MolkkyPlayFeature: ReducerProtocol {

    // MARK: Constants

    /// Undo Manager
    private let undoManager = PlayActionUndoManager()

    /// 得点の最大上限
    private static let maxLimitScore = 50

    /// 得点の半減値
    private static let halfScore = 25

    /// 失敗の最大回数
    private static let maxMistakeCount = 3

    /// State
    struct State: Equatable {
        /// チーム情報
        var teams: [Team]
        /// セット数
        let setNo: Int
        /// 選択されたスキットル
        var selectedSkittles: [Skittle] = []
        /// プレイ順
        var playingOrder = 0
        /// 試合を終わらせるか
        var shouldFinishMatch = false
        /// Undoのアクション管理配列
        var undoActions: [PlayAction] = []

        /// Initialize
        /// - Parameter teams: Team
        init(teams: [Team]) {
            self.teams = teams
            // 適当なチームから最後のセットは何かを取得する
            // 全てのチームはスコア配列の数が同じになるはずなのでこれが使える（FIXME: 直したい）
            setNo = teams.first?.score.last?.setNo ?? 1
        }
    }

    // MARK: Enumeration

    /// Action
    enum Action: Equatable {
        /// スキットルをタップした
        case didTapSkittle(_ skittle: Skittle)
        /// 戻るボタンをタップした
        case didTapUndoButton
        /// 試合終了ボタンをタップした
        case didTapCloseButton
        /// 決定ボタンをタップした
        case didTapDecideButton
        /// 試合が終了した
        case finishMatch
    }

    // MARK: Reduce

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didTapSkittle(let skittle):
            if let index = state.selectedSkittles.firstIndex(of: skittle) {
                state.selectedSkittles.remove(at: index)
            } else {
                state.selectedSkittles.append(skittle)
            }
            return .none

        case .didTapUndoButton:
            guard let lastAction = undoManager.actions.last else {
                return .none
            }

            state.teams = lastAction.teams
            state.playingOrder = lastAction.playingOrder

            undoManager.delete(lastAction)
            state.undoActions = undoManager.actions
            return .none

        case .didTapCloseButton:
            PageRouter.shared.path.removeAll()
            return .none

        case .didTapDecideButton:
            let playingOrder = state.playingOrder
            let team = state.teams[playingOrder]

            // ※結果画面から戻ってきて、その後決定を押すと不要なログが残ってしまうケースがある
            // よって、失格になっているチームが選択できる時と50点とったチームの時はログに残さないようにする
            if !team.isDisqualified && !isOverMatch(from: state) {
                let action = PlayAction(teams: state.teams, playingOrder: playingOrder)
                undoManager.add(action)
                state.undoActions = undoManager.actions
            }

            update(from: &state)
            resetSkittles(from: &state)

            return .none

        case .finishMatch:
            raiseMaxScoreIfNeeded(from: &state)

            let sortedTeams = rankSortedTeams(with: state.teams)
            PageRouter.shared.path.append(.result(teams: sortedTeams))
            return .none
        }
    }
}

// MARK: Private Methods
private extension MolkkyPlayFeature {

    /// 更新系の処理
    /// - Parameter state: State
    func update(from state: inout State) {
        if !isOverMatch(from: state) {
            updateScore(from: &state)
            updateMistakeCount(from: &state)
        }

        judgeFinishMatch(from: &state)

        if !state.shouldFinishMatch {
            updateMemberOrder(from: &state)
            updatePlayingOrder(from: &state)
        }
    }

    /// チームの得点を更新する
    /// - Parameter state: State
    func updateScore(from state: inout State) {
        let index = state.playingOrder

        guard !state.teams[index].isDisqualified else {
            return
        }

        let score = calculatePoint(from: state)
        let totalScore = state.teams[index].score[state.setNo - 1].score + score
        state.teams[index].score[state.setNo - 1].score = updateScoreIfNeeded(totalScore)
    }

    /// スコア上限を超えているかを確認して正しいスコアを返す
    /// - Parameter score: 元の得点
    /// - Returns: 正しいスコア
    func updateScoreIfNeeded(_ score: Int) -> Int {
        return score > type(of: self).maxLimitScore ? type(of: self).halfScore : score
    }

    /// 失敗した回数を更新する
    /// - Parameter state: State
    func updateMistakeCount(from state: inout State) {
        let index = state.playingOrder

        guard !state.teams[index].isDisqualified else {
            return
        }

        let score = calculatePoint(from: state)

        if score == .zero {
            state.teams[index].mistakeCount += 1
        } else {
            state.teams[index].mistakeCount = .zero
        }

        if state.teams[index].mistakeCount == type(of: self).maxMistakeCount {
            state.teams[index].isDisqualified = true
            state.teams[index].score[state.setNo - 1].score = .zero
        }
    }

    /// 得点を計算する
    /// - Parameter state: State
    /// - Returns: 得点
    func calculatePoint(from state: State) -> Int {
        if state.selectedSkittles.isEmpty {
            return .zero
        } else if
            state.selectedSkittles.count == 1,
            let skittle = state.selectedSkittles.first {
            return skittle.number
        } else {
            return state.selectedSkittles.count
        }
    }

    /// チーム内のメンバーのプレイ順を更新する
    /// - Parameter state: State
    func updateMemberOrder(from state: inout State) {
        let index = state.playingOrder
        let team = state.teams[index]
        if team.memberOrder < team.members.count - 1 {
            state.teams[index].memberOrder += 1
        } else {
            state.teams[index].memberOrder = .zero
        }
    }

    /// プレイ順を更新する
    /// - Parameter state: State
    func updatePlayingOrder(from state: inout State) {
        next(from: &state)

        // 失格しているチームがあればその分スキップする
        while state.teams[state.playingOrder].isDisqualified {
            next(from: &state)
        }
    }

    /// プレイ順を次のチームにする
    /// - Parameter state: State
    func next(from state: inout State) {
        if state.playingOrder < state.teams.count - 1 {
            state.playingOrder += 1
        } else {
            state.playingOrder = .zero
        }
    }

    /// 選択されたスキットルを削除する
    /// - Parameter state: State
    func resetSkittles(from state: inout State) {
        state.selectedSkittles.removeAll()
    }

    /// 試合を終わらせるかを判断する
    /// - Parameter state: State
    func judgeFinishMatch(from state: inout State) {
        // 1チームでプレイ中に3回ミスしたかどうか
        let disqualifiedTeams = state.teams.filter({ $0.isDisqualified })
        let isOnlyTeamDisqualified = (state.teams.count == 1) && (disqualifiedTeams.count == 1)

        state.shouldFinishMatch = isOnlyTeamRemained(from: state) || isOnlyTeamDisqualified || isOverMatch(from: state)
    }

    /// 1チームだけ残った場合、自動的に50点を獲得させる
    /// - Parameter state: State
    func raiseMaxScoreIfNeeded(from state: inout State) {
        guard 
            isOnlyTeamRemained(from: state),
            let index = state.teams.firstIndex(where: { !$0.isDisqualified }) else {
            return
        }

        state.teams[index].score[state.setNo - 1].score = type(of: self).maxLimitScore
    }

    /// 複数チームでプレイ中に1チームだけ残ったかどうか
    /// - Parameter state: State
    /// - Returns: true: 1チーム残った / false: 複数チーム残っている
    func isOnlyTeamRemained(from state: State) -> Bool {
        let disqualifiedTeams = state.teams.filter({ $0.isDisqualified })
        return (disqualifiedTeams.count + 1) == state.teams.count && state.teams.count > 1
    }
    
    /// 50点とったチームがいて試合が終了するか
    /// - Parameter state: State
    /// - Returns: true: 試合終了 / false: 継続
    func isOverMatch(from state: State) -> Bool {
        let index = state.playingOrder
        let playedTeam = state.teams[index]
        let playedTeamScore = playedTeam.score[state.setNo - 1].score
        return playedTeamScore == type(of: self).maxLimitScore
    }

    /// ランキング順に入れ替えたチーム情報
    /// - Parameter oldTeams: ソート前のチーム情報
    /// - Returns: ソート完了したチーム情報
    func rankSortedTeams(with oldTeams: [Team]) -> [Team] {
        var newTeams = oldTeams
        let totalScores = newTeams.map { $0.totalScore() }
        let index = totalScores.indices.sorted { totalScores[$0] > totalScores[$1] }
        newTeams = index.map { newTeams[$0] }

        var ranking = 1
        for index in 0..<newTeams.count {
            newTeams[index].ranking = ranking

            ranking += 1
        }

        return newTeams
    }
}
