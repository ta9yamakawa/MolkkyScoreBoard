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
        /// 選択されたスキットル
        var selectedSkittles: [Skittle] = []
        /// プレイ順
        var playingOrder = 0
    }

    /// Action
    enum Action {
        /// スキットルをタップした
        case didTapSkittle(_ skittle: Skittle)
        /// 戻るボタンをタップした
        case didTapUndoButton
        /// 決定ボタンをタップした
        case didTapDecideButton
    }

    /// Reduce
    /// - Parameters:
    ///   - state: State
    ///   - action: Action
    /// - Returns: EffectTask<Action>
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didTapSkittle(let skittle):
            if let index = state.selectedSkittles.firstIndex(of: skittle) {
                state.selectedSkittles.remove(at: index)
            } else {
                state.selectedSkittles.append(skittle)
            }
            return .none

        case .didTapUndoButton:
            return .none

        case .didTapDecideButton:
            updateScore(from: &state)
            updatePlayingOrder(from: &state)
            return .none
        }
    }
}

// MARK: Private Methods
private extension MolkkyPlayFeature {
    /// チームの得点を更新する
    /// - Parameter state: State
    func updateScore(from state: inout State) {
        let score = calculatePoint(from: state)
        let index = state.playingOrder

        if state.isLatterHalf {
            state.teams[index].latterHalfScore += score
        } else {
            state.teams[index].firstHalfScore += score
        }
    }

    /// 得点を計算する
    /// - Parameter state: State
    /// - Returns: 得点
    func calculatePoint(from state: State) -> Int {
        if state.selectedSkittles.isEmpty {
            return .zero
        } else if
            state.selectedSkittles.count == 1,
            let skittle = state.selectedSkittles.first {
            return skittle.number
        } else {
            return state.selectedSkittles.count
        }
    }

    /// プレー順を更新する
    /// - Parameter state: State
    func updatePlayingOrder(from state: inout State) {
        if state.playingOrder < state.teams.count - 1 {
            state.playingOrder += 1
        } else {
            state.playingOrder = .zero
        }
    }
}
