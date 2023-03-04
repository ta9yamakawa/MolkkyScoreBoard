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
            return .none
        }
    }
}
