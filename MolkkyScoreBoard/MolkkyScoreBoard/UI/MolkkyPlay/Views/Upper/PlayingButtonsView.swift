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

    /// モーダル遷移しているかどうか
    @State private var isPresented = false

    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    var body: some View {
        HStack() {
            Button("戻る") {
                viewStore.send(.didTapUndoButton)
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
                if viewStore.state.shouldFinishMatch {
                    isPresented.toggle()
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                ResultView(store: store(from: viewStore.state.teams))
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

// MARK: Private Methods
private extension PlayingButtonsView {
    /// Storeを生成する
    /// - Parameter teams: Team情報
    /// - Returns: StoreOf<ResultFeature>
    func store(from teams: [Team]) -> StoreOf<ResultFeature> {
        let state = ResultFeature.State(teams: teams)

        return Store(initialState: state,
                     reducer: ResultFeature())
    }

}

// MARK: Previews
struct PlayingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data,
                                            setNo: 1)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        PlayingButtonsView(viewStore: viewStore)
    }
}
