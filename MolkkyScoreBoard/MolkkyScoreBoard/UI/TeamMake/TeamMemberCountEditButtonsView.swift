//
//  TeamMemberCountEditButtonsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/21.
//

import SwiftUI
import ComposableArchitecture

/// チームメンバー数を操作するボタンView
struct TeamMemberCountEditButtonsView: View {

    // MARK: Constants

    /// Team Make Feature
    let store: StoreOf<TeamsMakeFeature>

    /// チーム
    let team: Team

    /// チーム Index
    let teamIndex: Int

    /// チームの最小人数
    private static let minTeamMemberCount = 1

    /// チームの最大人数
    private static let maxTeamMemberCount = 4

    // MARK: Body

    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack(spacing: 10) {
                Spacer()

                Button(action: {
                    viewStore.send(.didTapTeamAddButton(team: teamIndex))
                }, label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundColor(Color.blue)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                })
                .buttonStyle(PlainButtonStyle())
                .disabled(team.members.count >= type(of: self).maxTeamMemberCount)

                Button(action: {
                    viewStore.send(.didTapTeamRemoveButton(team: teamIndex))
                }, label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                })
                .buttonStyle(PlainButtonStyle())
                .disabled(team.members.count <= type(of: self).minTeamMemberCount)

                Spacer()
            }
        }
    }
}

// MARK: Previews
struct TeamMemberCountEditButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())
        let team = Team(id: 0, members: [TeamMember(name: "", order: 0)],
                        score: [TeamScore(setNo: 1, score: 50)])
        
        TeamMemberCountEditButtonsView(store: store, team: team, teamIndex: 1)
    }
}
