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
        VStack(spacing: 0) {
            TeamScoresTitleView()
            ScrollView {
                TeamScoresRowsView(viewStore: viewStore)
            }
        }
    }
}

// MARK: Previews
struct TeamScoresView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data,
                                            setNo: 1)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        TeamScoresView(viewStore: viewStore)
    }
}
