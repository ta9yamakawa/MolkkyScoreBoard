//
//  TeamsOrderEditView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/21.
//

import SwiftUI
import ComposableArchitecture

/// チームの順番決定画面
struct TeamsOrderEditView: View {

    /// Store
    let store: StoreOf<TeamsOrderEditFeature>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 0) {
                List {
                    ForEach(viewStore.state.teams) { team in
                        OrderingTeamView(team: team)
                    }
                    .onMove(perform: { source, destination in
                        viewStore.send(.didMovedTaamView(source: source,
                                                         destination: destination))
                    })
                }
                .environment(\.editMode, .constant(.active))
            }
        }
    }
}

// MARK: Previews
struct TeamsOrderEditView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")])]
        let store = Store(initialState: TeamsOrderEditFeature.State(teams: teams),
                          reducer: TeamsOrderEditFeature())
        TeamsOrderEditView(store: store)
    }
}
