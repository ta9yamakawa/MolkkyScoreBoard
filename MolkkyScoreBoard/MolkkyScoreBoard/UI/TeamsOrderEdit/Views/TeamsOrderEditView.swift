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

    /// モーダル遷移をしているかどうか
    @State private var isPresented = false

    /// Store
    let store: StoreOf<TeamsOrderEditFeature>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("プレイするチームの順番に\n並び替えてください")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .font(Font.system(size: 20))

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
                .environment(\.editMode, .constant(.active))

                Divider().background(Color.black)

                Button {
                    isPresented.toggle()
                } label: {
                    Text("決定")
                }
                .fullScreenCover(isPresented: $isPresented) {
                    MolkkyPlayView(store: store(teams: viewStore.state.teams))
                }
                .padding(.vertical, 5)
            }
        }
    }
}

// MARK: Private Methods
private extension TeamsOrderEditView {
    /// Storeを取得
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<MolkkyPlayFeature>
    func store(teams: [Team]) -> StoreOf<MolkkyPlayFeature> {
        let initialState = MolkkyPlayFeature.State(teams: teams, isLatterHalf: false)
        return Store(initialState: initialState,
                     reducer: MolkkyPlayFeature())
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
