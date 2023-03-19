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

        /// Initialize
        /// - Parameter teamCount: チーム数
        init(teamCount: Int) {
            var initialTeams: [Team] = []

            for index in 0..<teamCount {
                let id = index + 1
                let team = Team(id: id ,
                                members: [TeamMember(name: "", order: 0)],
                                order: index,
                                score: [TeamScore(setNo: 1, score: 0)])
                initialTeams.append(team)
            }

            self.teams = initialTeams
        }
    }

    /// Action
    enum Action {
        // チームメイト名入力のテキストフィールドの値変更
        case didChangedTextFiled(team: Int, member: Int , text: String)
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
        case .didChangedTextFiled(team: let teamIndex, member: let memberIndex, text: let text):
            state.teams[teamIndex].members[memberIndex].name = text
            return .none

        case .didTapTeamAddButton(team: let teamIndex):
            let newMember = TeamMember(name: "", order: state.teams[teamIndex].members.count)
            state.teams[teamIndex].members.append(newMember)
            return .none

        case .didTapTeamRemoveButton(team: let teamIndex):
            state.teams[teamIndex].members.removeLast()
            return .none

        case .didTapDecisionButton:
            //            state.teams = []
            return .none
        }
    }
}
