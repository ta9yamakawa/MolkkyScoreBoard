//
//  PlayingButtonsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI
import ComposableArchitecture

/// モルックプレイ中のボタンに関するView
struct PlayingButtonsView: View {
    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    var body: some View {
        HStack() {
            Button("戻る") {
                // TODO: 一個前に戻る処理を書く
                print("undo")
            }
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 40)
            .background(Color.gray)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 10,
                                bottom: 0,
                                trailing: 0))

            Spacer()

            Button("決定") {
                viewStore.send(.didTapDecideButton)
            }
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 40)
            .background(Color.orange)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))
        }
    }
}

// MARK: Previews
struct PlayingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")],
                          order: 0),
                     Team(id: 2,
                          members: [TeamMember(name: "huga")],
                          order: 1)]
        let state = MolkkyPlayFeature.State(teams: teams,
                                            isLatterHalf: false)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        PlayingButtonsView(viewStore: viewStore)
    }
}
