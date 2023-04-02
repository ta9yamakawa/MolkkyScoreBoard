//
//  TeamsMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import Algorithms
import SwiftUI
import ComposableArchitecture

/// チーム作成画面
struct TeamsMakeView: View {

    /// Store
    let store: StoreOf<TeamsMakeFeature>

    /// Router
    @ObservedObject var router: PageRouter

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
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
                                Text("失敗している")
                            }

                            TeamMemberCountEditButtonsView(store: store,
                                                           team: team,
                                                           teamIndex: teamIndex)
                        }
                    }
                }.padding(.top)
                
                Divider().background(Color.black)

                Button("決定") {
                    viewStore.send(.didTapDecisionButton)
                    router.path.append(DestinationType.teamOrderEdit(teams: viewStore.state.teams))
                }
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.orange)
                .cornerRadius(4)
            }
        }
    }
}

// MARK: Private Methods
private extension TeamsMakeView {
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
struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())

        TeamsMakeView(store: store, router: PageRouter())
    }
}
