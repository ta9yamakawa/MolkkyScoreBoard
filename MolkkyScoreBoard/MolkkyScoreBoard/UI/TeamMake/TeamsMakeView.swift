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

    @State private var inputText = ""

    /// Team Make Feature
    let store: StoreOf<TeamsMakeFeature>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                List {
                    ForEach(viewStore.state.teams.indexed(),
                            id: \.index) { teamIndex, team in
                        VStack {
                            HStack {
                                Text("Team\(team.id)")
                                Spacer()
                            }.padding(.leading)

                            ForEach(team.members.indexed(), id: \.index) { memberIndex, member in
                                TextField("メンバー名を入力",
                                          text: viewStore.binding(get: { _ in  member.name }, send: { .didChangedTextFiled(team: teamIndex, member: memberIndex, text: $0) }))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }

                            TeamMemberCountEditButtonsView(store: store,
                                                           team: team,
                                                           teamIndex: teamIndex)
                        }
                    }
                }.padding(.top)
                
                Divider().background(Color.black)

                NavigationLink(destination: TeamsOrderEditView(teams: viewStore.state.teams),
                               label: {
                    Text("決定")
                }).padding(.vertical, 5)
            }
        }
    }
}

// MARK: Previews
struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())

        TeamsMakeView(store: store)
    }
}
