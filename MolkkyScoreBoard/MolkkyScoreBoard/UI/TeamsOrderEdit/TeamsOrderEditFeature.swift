//
//  TeamsOrderEditFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/21.
//

import Foundation
import ComposableArchitecture

/// チームの順番決定 Feature
struct TeamsOrderEditFeature: ReducerProtocol {

    /// State
    struct State: Equatable {
        var teams: [Team]
    }

    /// Action
    enum Action {
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        return .none
    }
}
