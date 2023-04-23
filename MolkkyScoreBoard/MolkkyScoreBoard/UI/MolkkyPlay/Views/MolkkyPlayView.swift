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

    @State var shouldShowAlert = false

    /// Store
    let store: StoreOf<MolkkyPlayFeature>

    var body: some View {
        VStack(spacing: 20) {
            WithViewStore(store) { viewStore in
                HStack {
                    Button(action: {
                        shouldShowAlert.toggle()
//                        viewStore.send(.showAlert)
//                        viewStore.send(.didTapCloseButton)
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .alert("Important message",
                           isPresented: $shouldShowAlert) {
                               Button("OK", role: .cancel) { }
                           }

                    Spacer()
                }
                .padding()


                SkittlesView(viewStore: viewStore)
                    .padding(.bottom, 10)

                PlayingButtonsView(viewStore: viewStore)

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
                                    reducer: MolkkyPlayFeature()))
    }
}
