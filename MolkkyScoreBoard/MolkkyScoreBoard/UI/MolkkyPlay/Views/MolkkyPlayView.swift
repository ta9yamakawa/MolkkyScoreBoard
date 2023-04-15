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

    /// Store
    let store: StoreOf<MolkkyPlayFeature>

    /// Router
    @ObservedObject var router: PageRouter

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    router.path.removeAll()
                }, label: {
                    Image(systemName: "xmark")
                })
                Spacer()
            }
            .padding()

            WithViewStore(store) { viewStore in
                SkittlesView(viewStore: viewStore)
                    .padding(.bottom, 10)

                PlayingButtonsView(viewStore: viewStore,
                                   router: router)

                TeamScoresView(viewStore: viewStore)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Previews
struct MolkkyPlayView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data)
        MolkkyPlayView(store: Store(initialState: state,
                                    reducer: MolkkyPlayFeature()),
                       router: PageRouter.shared)
    }
}
