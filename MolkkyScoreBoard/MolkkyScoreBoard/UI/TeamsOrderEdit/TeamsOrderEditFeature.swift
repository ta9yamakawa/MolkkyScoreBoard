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
        /// チームを入れ替えた
        case didMovedTeamView(source: IndexSet, destination: Int)
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didMovedTeamView(source: let source, destination: let destination):
            move(from: source, to: destination, state: &state)
            return .none
        }
    }
}

// MARK: Private Methods
private extension TeamsOrderEditFeature {
    /// チームの並び替え
    /// - Parameters:
    ///   - source: 起点
    ///   - destination: 入れ替え箇所
    ///   - state: State
    func move(from source: IndexSet, to destination: Int, state: inout State) {
        guard
            let source = source.first,
            source != destination else {
            return
        }

        // Listの行を下に移動する場合
        if source < destination {
            for i in (source + 1)...(destination - 1) {
                state.teams[i].order -= 1

            }
            state.teams[source].order = destination - 1

        // Listの行を上に移動する場合
        } else if destination < source {
            for i in (destination...(source - 1)).reversed() {
                state.teams[i].order += 1
            }
            state.teams[source].order = destination
        }

        let sortedTeams = state.teams.sorted(by: { $0.order < $1.order })
        state.teams = sortedTeams
    }
}
