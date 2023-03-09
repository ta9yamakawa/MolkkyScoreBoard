//
//  SkittleView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI
import ComposableArchitecture

/// スキットル View
struct SkittleView: View {
    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    /// スキットルに記載される数（得点）
    let number: Int

    var body: some View {
        let selectedSkittles = viewStore.state.selectedSkittles

        Button("\(number)") {
            viewStore.send(.didTapSkittle(Skittle(number: number)))
        }
        .frame(width: 60, height: 60)
        .font(Font.system(size: 24))
        .bold()
        .foregroundColor(foregroundColor(with: selectedSkittles))
        .background(backgroundColor(with: selectedSkittles))
        .clipShape(Circle())
    }
}

// MARK: Private Methods
private extension SkittleView {
    /// 文字色を取得する
    /// - Parameter selecteds: 選択済みのスキットル(配列)
    /// - Returns: 文字色
    func foregroundColor(with selecteds: [Skittle]) -> Color {
        return isSelected(in: selecteds) ? .black : .white
    }

    /// 背景色を取得する
    /// - Parameter selecteds: 選択済みのスキットル(配列)
    /// - Returns: 背景色
    func backgroundColor(with selecteds: [Skittle]) -> Color {
        return isSelected(in: selecteds) ? .green : .blue
    }

    /// 選択されたスキットルかどうか
    /// - Parameter selecteds: 選択済みのスキットル(配列)
    /// - Returns: true: 選択済み / false: 未選択
    func isSelected(in selecteds: [Skittle]) -> Bool {
        return selecteds.contains(Skittle(number: number))
    }
}

// MARK: Previews
struct SkittleView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data,
                                            isLatterHalf: false)

        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        SkittleView(viewStore: viewStore, number: 12)
    }
}
