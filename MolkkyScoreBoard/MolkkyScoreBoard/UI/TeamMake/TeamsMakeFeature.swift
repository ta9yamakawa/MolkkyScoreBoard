//
//  TeamsMakeFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

import Foundation
import ComposableArchitecture

/// チーム作成
struct TeamsMakeFeature: ReducerProtocol {
    /// State
    struct State: Equatable {
        /// チームの情報
        var teams: [Team]

        /// バリデーションが通っていないチームの情報
        var invalidIndex: [InvalidTeamIndex] = []

        /// 決定を押して次に行けるかを判定するフラグ
        var enableGoNext = true

        /// Initialize
        /// - Parameter teamCount: チーム数
        init(teamCount: Int) {
            var initialTeams: [Team] = []

            for index in 0..<teamCount {
                let id = index + 1
                let team = Team(id: id ,
                                members: [TeamMember(name: "", order: 0)],
                                order: index)
                initialTeams.append(team)
            }

            self.teams = initialTeams
        }
    }

    /// Action
    enum Action {
        // チームメイト名入力のテキストフィールドの値変更
        case didChangedTextField(team: Int, member: Int , text: String)
        /// チームメイト追加ボタンタップ
        case didTapTeamAddButton(team: Int)
        /// チームメイト削減ボタンタップ
        case didTapTeamRemoveButton(team: Int)
        /// 決定ボタンタップ
        case didTapDecisionButton
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didChangedTextField(team: let teamIndex, member: let memberIndex, text: let text):
            state.teams[teamIndex].members[memberIndex].name = text

            validation(to: text, teamIndex: teamIndex, memberIndex: memberIndex, with: &state)
            updateEnableGoNext(with: &state)
            return .none

        case .didTapTeamAddButton(team: let teamIndex):
            let newMember = TeamMember(name: "", order: state.teams[teamIndex].members.count)
            state.teams[teamIndex].members.append(newMember)
            return .none

        case .didTapTeamRemoveButton(team: let teamIndex):
            let membersLastIndex = state.teams[teamIndex].members.count - 1
            state.teams[teamIndex].members.removeLast()

            removeValidationIfNeeded(from: teamIndex, memberIndex: membersLastIndex, with: &state)
            return .none

        case .didTapDecisionButton:
            for index in 0..<state.teams.count {
                let newScore = newScore(from: state.teams)
                state.teams[index].score.append(newScore)
            }

            let path: DestinationType = state.teams.count == 1 ? .play(teams: state.teams) : .teamOrderEdit(teams: state.teams)
            PageRouter.shared.path.append(path)
            return .none
        }
    }
}

// Private Methods
private extension TeamsMakeFeature {
    /// バリデーションを実施する
    /// - Parameters:
    ///   - name: 入力した名前
    ///   - teamIndex: どこのチームの
    ///   - memberIndex: どのメンバーか
    ///   - state: State
    func validation(to name: String,
                    teamIndex: Int,
                    memberIndex: Int,
                    with state: inout State) {
        let validator = NameValidator(name: name)

        switch validator.validate() {
        case .success:
            state.invalidIndex.removeAll(where: { ($0.team == teamIndex) && ($0.member == memberIndex) })

        case .maxLimitLength(let count):
            let index = InvalidTeamIndex(team: teamIndex,
                                         member: memberIndex,
                                         errorType: .maxLimitLength(count))
            state.invalidIndex.append(index)
        }
    }

    /// 決定を押して次画面に行けるかのフラグを更新する
    /// - Parameter state: State
    func updateEnableGoNext(with state: inout State) {
        state.enableGoNext = state.invalidIndex.isEmpty
    }

    /// バリデーションが必要な時に削除する
    /// - Parameters:
    ///   - teamIndex: チームIndex
    ///   - memberIndex: メンバーインデックス
    ///   - state: State
    func removeValidationIfNeeded(from teamIndex: Int,
                                  memberIndex: Int,
                                  with state: inout State) {
        state.invalidIndex.removeAll(where: {
            ($0.team == teamIndex) && ($0.member == memberIndex)
        })
    }

    /// 新たなTeamScoreを取得する
    /// - Parameter teams: 全チーム情報
    /// - Returns: TeamScore
    func newScore(from teams: [Team]) -> TeamScore {
        if
            let team = teams.first,
            let setNo = team.score.last?.setNo {
            return TeamScore(setNo: setNo + 1, score: .zero)
        } else {
            return TeamScore(setNo: 1, score: .zero)
        }
    }
}
