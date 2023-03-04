//
//  MolkkyPlayFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/02.
//

import ComposableArchitecture

/// プレイ画面 Feature
struct MolkkyPlayFeature: ReducerProtocol {

    /// State
    struct State: Equatable {
        /// チーム情報
        var teams: [Team]
        /// 後半かどうか
        let isLatterHalf: Bool
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
