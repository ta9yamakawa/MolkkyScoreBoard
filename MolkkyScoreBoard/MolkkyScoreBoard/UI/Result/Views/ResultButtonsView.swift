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

    var body: some View {
        HStack(spacing: 10) {
            Spacer()

            Button("ゲーム終了") {
                viewStore.send(.didTapFinishButton)
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

            Button("次のセットへ") {
                viewStore.send(.didTapNextMatchButton)
            }
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

// MARK: Previews
struct ResultButtonsView_Previews: PreviewProvider {
    static var previews: some View {

        let state = ResultFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<ResultFeature>(initialState: state,
                                                         reducer: ResultFeature()))
        ResultButtonsView(viewStore: viewStore)
    }
}
