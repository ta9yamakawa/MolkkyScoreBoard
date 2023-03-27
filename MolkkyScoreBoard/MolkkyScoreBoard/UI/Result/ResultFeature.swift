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
            return .none

        case .didTapNextMatchButton:
            resetIsDisqualified(from: &state)
            sortByPlayingOrder(from: &state)
            return .none
        }
    }
}

// MARK: Private Methods
private extension ResultFeature {
    /// 失格のフラグを全てリセットする
    /// - Parameter state: State
    func resetIsDisqualified(from state: inout State) {
        let teamCount = state.teams.count

        for index in 0..<teamCount {
            state.teams[index].mistakeCount = .zero
            state.teams[index].isDisqualified = false
        }
    }

    /// プレイ順に入れ替える
    /// - Parameter state: State
    func sortByPlayingOrder(from state: inout State) {
        let sortedTeams = state.teams.sorted(by: { $0.order < $1.order })
        state.teams = sortedTeams
    }
}
