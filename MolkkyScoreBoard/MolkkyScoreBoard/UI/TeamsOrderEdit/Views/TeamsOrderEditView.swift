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
                HStack {
                    Spacer()
                    EditButton()
                        .padding(.trailing, 15.0)
                }
                .padding()
                .background(Color(.systemGray6))

                List {
                    ForEach(viewStore.state.teams) { team in
                        OrderingTeamView(team: team)
                    }
                    .onMove(perform: { indices, newOffset in
                        var teams = viewStore.state.teams
                        teams.move(fromOffsets: indices,
                                   toOffset: newOffset)
                    })
                }
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
