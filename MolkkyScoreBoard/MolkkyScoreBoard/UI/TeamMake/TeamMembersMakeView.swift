//
//  TeamMembersMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/03.
//

import Algorithms
import SwiftUI
import ComposableArchitecture

/// チームメンバー作成 View
struct TeamMembersMakeView: View {

    /// View Store
    let viewStore: ViewStore<TeamsMakeFeature.State,
                             TeamsMakeFeature.Action>

    var body: some View {
        let state = viewStore.state

        List {
            ForEach(state.teams.indexed(),
                    id: \.index) { teamIndex, team in
                VStack {
                    HStack {
                        Text("Team\(team.id)")
                        Spacer()
                    }.padding(.leading)

                    NameFormsView(viewStore: viewStore,
                                  team: team,
                                  teamIndex: teamIndex)

                    if shouldShowValidationError(from: state.invalidIndex,
                                                 index: teamIndex) {
                        let invalid = viewStore.state.invalidIndex
                        Text(invalid[0].errorType?.message ?? "失敗している")
                    }
                    
                    TeamMemberCountEditButtonsView(viewStore: viewStore,
                                                   team: team,
                                                   teamIndex: teamIndex)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppColor.base.color)
    }
}

// MARK: Private Methods
private extension TeamMembersMakeView {
    /// バリデーションエラーを表示すべきか判定する
    /// - Parameters:
    ///   - datas: バリデーションエラーの情報
    ///   - index: チームIndex
    /// - Returns: true: 表示する / false: 表示しない
    func shouldShowValidationError(from datas: [InvalidTeamIndex],
                                   index: Int) -> Bool {
        guard !datas.isEmpty else {
            return false
        }

        return datas.first(where: { $0.team == index }) != nil
    }
}

// MARK: Previews
struct TeamMembersMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let state = TeamsMakeFeature.State(teamCount: 2)
        let viewStore = ViewStore(StoreOf<TeamsMakeFeature>(initialState: state,
                                                            reducer: TeamsMakeFeature()))
        TeamMembersMakeView(viewStore: viewStore)
    }
}
