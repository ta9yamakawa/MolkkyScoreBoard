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
    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    var body: some View {
        let bounds = UIScreen.main.bounds
        VStack(spacing: 10) {
            TeamScoresTitleView()

            ScrollView {
                ForEach(viewStore.state.teams.indexed(),
                        id: \.index) { index, team in
                    VStack {
                        HStack {
                            HStack(spacing: 20) {
                                if viewStore.state.playingOrder == index {
                                    Image(systemName: "arrow.right")
                                }

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

                            Text("\(team.firstHalfScore)")
                                .frame(width: bounds.width / 6)

                            Text("\(viewStore.state.teams[index].latterHalfScore)")
                                .frame(width: bounds.width / 6)

                            Text("\(totalScore(from: viewStore.state.teams[index]))")
                                .frame(width: bounds.width / 6)
                        }

                        Divider()
                    }
                }
            }
        }
    }
}

// MARK: Private Methods
private extension TeamScoresView {
    /// 合計点を取得する
    /// - Parameter team: Team
    /// - Returns: 合計点
    func totalScore(from team: Team) -> Int {
        return team.firstHalfScore + team.latterHalfScore
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
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        TeamScoresView(viewStore: viewStore)
    }
}
