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
                        viewStore.send(.didMovedTeamView(source: source,
                                                         destination: destination))
                    })
                }
                .environment(\.editMode, .constant(.active))
            }

            Divider().background(Color.black)

            NavigationLink(destination:
                            // TODO: プレイ画面に遷移させる
                            TeamsOrderEditView(store: store),
                           label: {
                Text("決定")
            }).padding(.vertical, 5)
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
