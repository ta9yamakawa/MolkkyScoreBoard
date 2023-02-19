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
        @BindableState var displayName = ""
        /// チームの情報
        var teams: [TeamDto]

        /// Initialize
        /// - Parameter teamCount: チーム数
        init(teamCount: Int) {
            var initialTeams: [TeamDto] = []

            for index in 0..<teamCount {
                let id = index + 1
                let team = TeamDto(id: id , members: [])
                initialTeams.append(team)
            }

            self.teams = initialTeams
        }
    }

    /// Action
    enum Action: Equatable {
        case didChangedTextFiled(teamId: Int, text: String)
        /// 決定ボタンタップ
        case didTapDecisionButton
        /// チームメイト名の決定タップ
        case didTapTeammateName
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .didChangedTextFiled(teamId: teamId, text: text):
            state.displayName = text
            return .none

        case .didTapDecisionButton:
            state.teams = []
            return .none


        case .didTapTeammateName:
            state.teams = []
            return .none
        }
    }
}
