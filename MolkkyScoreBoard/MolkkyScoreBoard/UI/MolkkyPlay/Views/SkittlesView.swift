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
    /// ストア
    let store: StoreOf<MolkkyPlayFeature>
    
    var body: some View {
        VStack {
            HStack {
                SkittleView(store: store, number: 7)
                SkittleView(store: store, number: 9)
                SkittleView(store: store, number: 8)
            }

            HStack {
                SkittleView(store: store, number: 5)
                SkittleView(store: store, number: 11)
                SkittleView(store: store, number: 12)
                SkittleView(store: store, number: 6)
            }

            HStack {
                SkittleView(store: store, number: 3)
                SkittleView(store: store, number: 10)
                SkittleView(store: store, number: 4)
            }

            HStack {
                SkittleView(store: store, number: 1)
                SkittleView(store: store, number: 2)
            }
        }
    }
}

// MARK: Previews
struct SkittlesView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")],
                          order: 0),
                     Team(id: 2,
                          members: [TeamMember(name: "huga")],
                          order: 1)]
        let state = MolkkyPlayFeature.State(teams: teams,
                                            isLatterHalf: false)
        SkittlesView(store: Store(initialState: state,
                                  reducer: MolkkyPlayFeature()))
    }
}
