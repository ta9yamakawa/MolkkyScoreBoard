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

            let userDefaults = UserDefaults.standard
            let key = UserDefaultsConstants.Key.playCompletedCount.rawValue
            var count = userDefaults.integer(forKey: key)
            count += 1
            userDefaults.set(count, forKey: key)
            return .none

        case .didTapNextMatchButton:
            resetIsDisqualified(from: &state)
            sortByPlayingOrder(from: &state)

            state.teams.enumerated().forEach { index, team in
                let newScore = TeamScore(from: team)
                state.teams[index].score.append(newScore)
            }

            let path: DestinationType = state.teams.count == 1 ? .play(teams: state.teams) : .teamOrderEdit(teams: state.teams)
            PageRouter.shared.path.append(path)
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
