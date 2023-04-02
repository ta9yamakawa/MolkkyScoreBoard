//
//  TeamsMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import Algorithms
import SwiftUI
import ComposableArchitecture

/// チーム作成画面
struct TeamsMakeView: View {

    /// Store
    let store: StoreOf<TeamsMakeFeature>

    /// Router
    @ObservedObject var router: PageRouter

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                TeamMembersMakeView(viewStore: viewStore)
                
                Divider().background(Color.black)

                Button("決定") {
                    viewStore.send(.didTapDecisionButton)
                    router.path.append(DestinationType.teamOrderEdit(teams: viewStore.state.teams))
                }
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.orange)
                .cornerRadius(4)
            }
        }
    }
}

// MARK: Previews
struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())

        TeamsMakeView(store: store, router: PageRouter())
    }
}
