//
//  TeamScoresRowsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/09.
//

import SwiftUI
import ComposableArchitecture

/// 各チームのスコア行View
struct TeamScoresRowsView: View {

    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewStore.state.teams.indexed(),
                    id: \.index) { index, team in
                VStack(spacing: 10) {
                    TeamScoresRowView(viewStore: viewStore, index: index)

                    Divider()
                        .padding(.top, 10)
                }
                .background(teamBackgroundColor(from: team, index: index))
            }
        }
    }
}

// MARK: Private Methods
private extension TeamScoresRowsView {
    /// チーム行の背景色を取得する
    /// - Parameter team: Team
    /// - Returns: チーム行の背景色
    func teamBackgroundColor(from team: Team, index: Int) -> Color {
        if viewStore.state.playingOrder == index {
            return AppColor.accent3.color
        } else if team.isDisqualified {
            return .gray
        } else {
            return .clear
        }
    }
}

// MARK: Previews
struct TeamScoresRowsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        TeamScoresRowsView(viewStore: viewStore)
    }
}
