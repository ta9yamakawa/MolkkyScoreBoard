//
//  MolkkyPlayView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/02.
//

import SwiftUI
import ComposableArchitecture

/// モルックプレイ画面
struct MolkkyPlayView: View {

    /// Dismiss
    @Environment(\.dismiss) private var dismiss

    /// Store
    let store: StoreOf<MolkkyPlayFeature>

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
                Spacer()
            }
            .padding()

            WithViewStore(store) { viewStore in
                SkittlesView(viewStore: viewStore)
                    .padding(.bottom, 10)

                PlayingButtonsView(viewStore: viewStore)

                TeamScoresView(viewStore: viewStore)
            }
        }
    }
}

// MARK: Previews
struct MolkkyPlayView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")],
                          order: 0),
                     Team(id: 2,
                          members: [TeamMember(name: "huga")],
                          order: 1)]
        let state = MolkkyPlayFeature.State(teams: teams,
                                            isLatterHalf: false)
        MolkkyPlayView(store: Store(initialState: state,
                                    reducer: MolkkyPlayFeature()))
    }
}
