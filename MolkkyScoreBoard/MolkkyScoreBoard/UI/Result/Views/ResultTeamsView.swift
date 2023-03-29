//
//  ResultTeamsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/22.
//

import SwiftUI
import ComposableArchitecture

/// チームの結果 View
struct ResultTeamsView: View {

    /// View Store
    let viewStore: ViewStoreOf<ResultFeature>

    var body: some View {
        List {
            ForEach(viewStore.state.teams) { team in
                ResultTeamView(team: team)
                    .listRowInsets(EdgeInsets(top: .zero,
                                              leading: .zero,
                                              bottom: 10,
                                              trailing: 10))
            }
        }
    }
}

// MARK: Previews
struct ResultTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = ResultFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<ResultFeature>(initialState: state,
                                                         reducer: ResultFeature()))
        ResultTeamsView(viewStore: viewStore)
    }
}
