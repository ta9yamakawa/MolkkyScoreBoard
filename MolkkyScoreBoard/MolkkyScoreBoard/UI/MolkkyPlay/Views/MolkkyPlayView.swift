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
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .alert(isPresented: $shouldShowAlert) {
                        gameFinishConfirmAlert(with: viewStore)
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

// MARK: Private Methods
private extension MolkkyPlayView {
    /// ゲームの終了確認アラートを取得する
    /// - Parameter viewStore: ViewStore
    /// - Returns: Alert
    func gameFinishConfirmAlert(with viewStore:
                                ViewStore<MolkkyPlayFeature.State,
                                MolkkyPlayFeature.Action>) -> Alert {
        let title = Text("ゲームを中断しますか？")
        let finishButton: Alert.Button = .default(Text("中断する"),
                                                  action: {
            viewStore.send(.didTapCloseButton)
        })
        let cancelButton: Alert.Button = .cancel(Text("キャンセル"))

        let alert = Alert(title: title,
                          primaryButton: finishButton,
                          secondaryButton: cancelButton)

        return alert
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
