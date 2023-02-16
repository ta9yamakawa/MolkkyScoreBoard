//
//  TeamMakeFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

import Foundation
import ComposableArchitecture

/// チーム作成
struct TeamMakeFeature: ReducerProtocol {
    /// State
    struct State: Equatable {
        /// チームの情報
        var teams: [TeamDto] = []
    }

    /// Action
    enum Action: Equatable {
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
        case .didTapDecisionButton:
            state.teams = []
            return .none


        case .didTapTeammateName:
            state.teams = []
            return .none
        }
    }
}
