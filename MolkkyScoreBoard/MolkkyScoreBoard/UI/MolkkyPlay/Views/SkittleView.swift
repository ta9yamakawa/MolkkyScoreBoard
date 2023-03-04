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
    /// ストア
    let store: StoreOf<MolkkyPlayFeature>

    /// スキットルに記載される数（得点）
    let number: Int

    var body: some View {
        WithViewStore(self.store) { viewStore in
            let selectedSkittles = viewStore.state.selectedSkittles

            Button(action: {
                viewStore.send(.didTapSkittle(Skittle(number: number)))
            }, label: {
                Text("\(number)")
            })
            .frame(width: 60, height: 60)
            .font(Font.system(size: 24))
            .bold()
            .foregroundColor(foregroundColor(with: selectedSkittles))
            .background(backgroundColor(with: selectedSkittles))
            .clipShape(Circle())
        }
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
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")],
                          order: 0),
                     Team(id: 2,
                          members: [TeamMember(name: "huga")],
                          order: 1)]
        let state = MolkkyPlayFeature.State(teams: teams,
                                            isLatterHalf: false)

        SkittleView(store: Store(initialState: state,
                                 reducer: MolkkyPlayFeature()),
                    number: 12)
    }
}
