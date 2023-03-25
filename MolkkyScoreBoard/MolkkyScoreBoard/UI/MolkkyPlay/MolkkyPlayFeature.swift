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
        /// 後半かどうか
        let setNo: Int
        /// 選択されたスキットル
        var selectedSkittles: [Skittle] = []
        /// プレイ順
        var playingOrder = 0
        /// 試合を終わらせるか
        var shouldFinishMatch = false

        /// Initialize
        /// - Parameter teams: Team
        init(teams: [Team]) {
            self.teams = teams
            // 適当なチームから最後のセットは何かを取得する
            // 全てのチームはスコア配列の数が同じになるはずなのでこれが使える（FIXME: 直したい）
            setNo = teams.first?.score.last?.setNo ?? 1
        }
    }

    /// Action
    enum Action {
        /// スキットルをタップした
        case didTapSkittle(_ skittle: Skittle)
        /// 戻るボタンをタップした
        case didTapUndoButton
        /// 決定ボタンをタップした
        case didTapDecideButton
    }

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

            state.teams[lastAction.playingOrder] = lastAction.team
            state.playingOrder = lastAction.playingOrder

            undoManager.delete(lastAction)
            return .none

        case .didTapDecideButton:
            let playingOrder = state.playingOrder
            let team = state.teams[playingOrder]
            let action = PlayAction(team: team, playingOrder: playingOrder)
            undoManager.add(action)

            update(from: &state)
            resetSkittles(from: &state)

            return .none
        }
    }
}

// MARK: Private Methods
private extension MolkkyPlayFeature {

    /// 更新系の処理
    /// - Parameter state: State
    func update(from state: inout State) {
        updateScore(from: &state)
        updateMistakeCount(from: &state)

        judgeFinishMatch(from: &state)

        if !state.shouldFinishMatch {
            updateMemberOrder(from: &state)
            updatePlayingOrder(from: &state)
        }
    }

    /// チームの得点を更新する
    /// - Parameter state: State
    func updateScore(from state: inout State) {
        let score = calculatePoint(from: state)
        let index = state.playingOrder

        let totalScore = state.teams[index].score[state.setNo - 1].score + score
        state.teams[index].score[state.setNo - 1].score = updayeScoreIfNeeded(totalScore)
    }

    /// スコア上限を超えているかを確認して正しいスコアを返す
    /// - Parameter score: 元の得点
    /// - Returns: 正しいスコア
    func updayeScoreIfNeeded(_ score: Int) -> Int {
        return score > type(of: self).maxLimitScore ? type(of: self).halfScore : score
    }

    /// 失敗した回数を更新する
    /// - Parameter state: State
    func updateMistakeCount(from state: inout State) {
        let score = calculatePoint(from: state)
        let index = state.playingOrder

        if score == .zero {
            state.teams[index].mistakeCount += 1
        } else {
            state.teams[index].mistakeCount = .zero
        }

        if state.teams[index].mistakeCount == type(of: self).maxMistakeCount {
            state.teams[index].isDisqualified = true
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
        let disqualifiedTeams = state.teams.filter({ $0.isDisqualified })
        let index = state.playingOrder
        let playedTeam = state.teams[index]
        let playedTeamScore = playedTeam.score[state.setNo - 1].score

        // 複数チームでプレイ中に1チームだけ残ったかどうか
        let isOnlyTeamRemained = (disqualifiedTeams.count + 1) == state.teams.count && state.teams.count > 1
        // 1チームでプレイ中に3回ミスしたかどうか
        let isOnlyTeamDisqualified = (state.teams.count == 1) && (disqualifiedTeams.count == 1)
        // 50点に達したチームがいるかどうか
        let isOverMatch = playedTeamScore == type(of: self).maxLimitScore
        state.shouldFinishMatch = isOnlyTeamRemained || isOnlyTeamDisqualified || isOverMatch
    }
}
