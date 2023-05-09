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
            VStack(spacing: .zero) {
                IntroductionTextView(message: "チームのプレイ順に並び替えてください")

                List {
                    ForEach(viewStore.state.teams) { team in
                        OrderingTeamView(team: team)
                            .listRowInsets(EdgeInsets(top: .zero,
                                                      leading: .zero,
                                                      bottom: 10,
                                                      trailing: 10))
                    }
                    .onMove(perform: { source, destination in
                        viewStore.send(.didMovedTeamView(source: source,
                                                         destination: destination))
                    })
                }
                .scrollContentBackground(.hidden)
                .environment(\.editMode, .constant(.active))

                Divider().background(Color.black).padding(.bottom)

                Button("決定") {
                    viewStore.send(.didTapDecideButton)
                }
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 140)
                .padding(.vertical, 12)
                .background(AppColor.accent2.color)
                .cornerRadius(4)
            }
            .background(AppColor.base.color)
        }
    }
}

// MARK: Previews
struct TeamsOrderEditView_Previews: PreviewProvider {
    static var previews: some View {
        let state = TeamsOrderEditFeature.State(teams: TeamsMock().data)
        let store = Store(initialState: state,
                          reducer: TeamsOrderEditFeature())
        TeamsOrderEditView(store: store)
    }
}
