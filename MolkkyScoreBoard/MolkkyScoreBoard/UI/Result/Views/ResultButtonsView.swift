//
//  ResultButtonsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/21.
//

import SwiftUI
import ComposableArchitecture

/// 結果画面のボタンに関するView
struct ResultButtonsView: View {

    /// View Store
    let viewStore: ViewStoreOf<ResultFeature>

    /// Dismiss
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack(spacing: 10) {
            Spacer()

            Button("ゲーム終了") {
                dismiss()
            }
            .padding(8)
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))

            NavigationLink(destination:
                            TeamsOrderEditView(store: store(teams: viewStore.state.teams)),
                           label: {
                Text("次のセットへ")
            })
            .padding(8)
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .background(Color.orange)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))

            Spacer()
        }
    }
}

// MARK: Private Methods
private extension ResultButtonsView {
    /// Storeを取得
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<TeamsOrderEditFeature>
    func store(teams: [Team]) -> StoreOf<TeamsOrderEditFeature> {
        let initialState = TeamsOrderEditFeature.State(teams: teams)
        return Store(initialState: initialState,
                     reducer: TeamsOrderEditFeature())
    }
}

// MARK: Previews
struct ResultButtonsView_Previews: PreviewProvider {
    static var previews: some View {

        let state = ResultFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<ResultFeature>(initialState: state,
                                                         reducer: ResultFeature()))
        ResultButtonsView(viewStore: viewStore)
    }
}
