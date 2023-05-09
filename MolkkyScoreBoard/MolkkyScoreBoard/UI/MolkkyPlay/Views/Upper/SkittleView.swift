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
        .foregroundColor(AppColor.white.color)
        .background(backgroundColor(with: selectedSkittles))
        .clipShape(Circle())
    }
}

// MARK: Private Methods
private extension SkittleView {
    /// 背景色を取得する
    /// - Parameter selecteds: 選択済みのスキットル(配列)
    /// - Returns: 背景色
    func backgroundColor(with selecteds: [Skittle]) -> Color {
        let isSelected = selecteds.contains(Skittle(number: number))
        return isSelected ? AppColor.main.color : AppColor.skittle.color
    }
}

// MARK: Previews
struct SkittleView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        SkittleView(viewStore: viewStore, number: 12)
    }
}
