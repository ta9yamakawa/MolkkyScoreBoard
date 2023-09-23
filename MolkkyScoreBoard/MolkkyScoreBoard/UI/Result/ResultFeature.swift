//
//  ResultFeature.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/20.
//

import Foundation
import ComposableArchitecture

/// チーム作成
struct ResultFeature: ReducerProtocol {
    /// State
    struct State: Equatable {
        /// チームの情報
        var teams: [Team]
    }

    /// Action
    enum Action {
        // 終了するボタンをタップする
        case didTapFinishButton
        // 次のゲームを開始するボタンをタップする
        case didTapNextMatchButton
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didTapFinishButton:
            PageRouter.shared.path.removeAll()

            UserDefaultsInteger.shared.increment(forKey: .playCompletedCount)
            return .none

        case .didTapNextMatchButton:
            sortByPlayingOrder(from: &state)

            let newTeams = state.teams.map { $0.teamForNextMatch() }
            let path: DestinationType = newTeams.count == 1 ? .play(teams: newTeams) : .teamOrderEdit(teams: newTeams)
            PageRouter.shared.path.append(path)
            return .none
        }
    }
}

// MARK: Private Methods
private extension ResultFeature {
    /// プレイ順に入れ替える
    /// - Parameter state: State
    func sortByPlayingOrder(from state: inout State) {
        let sortedTeams = state.teams.sorted(by: { $0.order < $1.order })
        state.teams = sortedTeams
    }
}
