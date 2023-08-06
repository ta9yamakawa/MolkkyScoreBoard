//
//  ResultView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/20.
//

import SwiftUI
import ComposableArchitecture

/// 結果 View
struct ResultView: View {

    /// Store
    let store: StoreOf<ResultFeature>

    var body: some View {
        VStack {
            WithViewStore(self.store) { viewStore in
                ResultTeamsView(viewStore: viewStore)
                ResultButtonsView(viewStore: viewStore)
                    .padding()
            }
        }
        .background(AppColor.base.color)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Previews
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let state = ResultFeature.State(teams: TeamsMock().data)
        let store = Store(initialState: state,
                          reducer: ResultFeature())

        ResultView(store: store)
    }
}
