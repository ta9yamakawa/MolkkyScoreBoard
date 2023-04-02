//
//  TeamMembersMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/03.
//

import Algorithms
import SwiftUI
import ComposableArchitecture

struct TeamMembersMakeView: View {

    /// View Store
    let viewStore: ViewStore<TeamsMakeFeature.State,
                             TeamsMakeFeature.Action>

    var body: some View {
        List {
            ForEach(viewStore.state.teams.indexed(),
                    id: \.index) { teamIndex, team in
                VStack {
                    HStack {
                        Text("Team\(team.id)")
                        Spacer()
                    }.padding(.leading)

                    ForEach(team.members.indexed(), id: \.index) { memberIndex, member in
                        TextField("メンバー名を入力",
                                  text: viewStore.binding(get: { _ in member.name },
                                                          send: { .didChangedTextField(team: teamIndex,
                                                                                       member: memberIndex,
                                                                                       text: $0) }))
                        .autocapitalization(.none)
                        .padding(5)
                        .background(textFieldBackgroundColor(from: viewStore.state.invalidIndex,
                                                             teamIndex: teamIndex,
                                                             memberIndex: memberIndex))
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }

                    if shouldShowValidationError(from: viewStore.state.invalidIndex,
                                                 index: teamIndex) {
                        let invalid = viewStore.state.invalidIndex
                        Text(invalid[0].errorType?.message ?? "失敗している")
                    }
                    
                    TeamMemberCountEditButtonsView(viewStore: viewStore,
                                                   team: team,
                                                   teamIndex: teamIndex)
                }
            }
        }.padding(.top)
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

    /// フォームの背景色を設定する
    /// - Parameters:
    ///   - datas: バリデーションエラーの情報
    ///   - teamIndex: チームIndex
    ///   - memberIndex: メンバーIndex
    /// - Returns: エラーが起きている場合は赤色、それ以外は透明
    func textFieldBackgroundColor(from datas: [InvalidTeamIndex],
                                  teamIndex: Int,
                                  memberIndex: Int) -> Color {
        guard
            shouldShowValidationError(from: datas, index: teamIndex),
            datas.first(where: { $0.member == memberIndex }) != nil else {
            return .clear
        }

        return .red
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
