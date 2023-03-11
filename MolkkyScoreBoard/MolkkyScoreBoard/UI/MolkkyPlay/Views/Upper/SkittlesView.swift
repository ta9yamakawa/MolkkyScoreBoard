//
//  SkittlesView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI
import ComposableArchitecture

/// スキットルの配置 View
struct SkittlesView: View {
    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>
    
    var body: some View {
        VStack {
            HStack {
                SkittleView(viewStore: viewStore, number: 7)
                SkittleView(viewStore: viewStore, number: 9)
                SkittleView(viewStore: viewStore, number: 8)
            }

            HStack {
                SkittleView(viewStore: viewStore, number: 5)
                SkittleView(viewStore: viewStore, number: 11)
                SkittleView(viewStore: viewStore, number: 12)
                SkittleView(viewStore: viewStore, number: 6)
            }

            HStack {
                SkittleView(viewStore: viewStore, number: 3)
                SkittleView(viewStore: viewStore, number: 10)
                SkittleView(viewStore: viewStore, number: 4)
            }

            HStack {
                SkittleView(viewStore: viewStore, number: 1)
                SkittleView(viewStore: viewStore, number: 2)
            }
        }
    }
}

// MARK: Previews
struct SkittlesView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data,
                                            setNo: 1)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        SkittlesView(viewStore: viewStore)
    }
}
