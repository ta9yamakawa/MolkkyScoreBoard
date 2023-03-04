//
//  TeamScoresView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI
import ComposableArchitecture

/// 各チームのスコアView
struct TeamScoresView: View {

    /// ストア
    let store: StoreOf<MolkkyPlayFeature>

    var body: some View {
        let bounds = UIScreen.main.bounds
        VStack(spacing: 10) {
            TeamScoresTitleView()

            ScrollView {
                WithViewStore(store) { viewStore in
                    ForEach(viewStore.state.teams.indexed(),
                            id: \.index) { index, team in
                        VStack {
                            HStack {
                                HStack(spacing: 20) {
                                    Image(systemName: "arrow.right")
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("チーム\(team.id)")
                                            .multilineTextAlignment(.leading)
                                        HStack(spacing: 5) {
                                            Circle()
                                                .frame(width: 20)
                                                .foregroundColor(Color.gray)
                                            Circle()
                                                .frame(width: 20)
                                                .foregroundColor(Color.gray)
                                            Circle()
                                                .frame(width: 20)
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                }
                                .frame(width: bounds.width / 2)

                                Text("0")
                                    .frame(width: bounds.width / 6)

                                Text("0")
                                    .frame(width: bounds.width / 6)

                                Text("0")
                                    .frame(width: bounds.width / 6)
                            }

                            Divider()
                        }
                    }
                }
            }
        }
    }
}

// MARK: Previews
struct TeamScoresView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")],
                          order: 0),
                     Team(id: 2,
                          members: [TeamMember(name: "huga")],
                          order: 1)]
        let state = MolkkyPlayFeature.State(teams: teams,
                                            isLatterHalf: false)
        TeamScoresView(store: Store(initialState: state,
                                    reducer: MolkkyPlayFeature()))
    }
}
