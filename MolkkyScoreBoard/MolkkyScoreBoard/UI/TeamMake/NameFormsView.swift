//
//  NameFormsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/03.
//

import SwiftUI
import ComposableArchitecture

/// 氏名のフォーム View
struct NameFormsView: View {

    /// View Store
    let viewStore: ViewStore<TeamsMakeFeature.State,
                             TeamsMakeFeature.Action>

    /// チームの情報
    let team: Team

    /// チームのIndex
    let teamIndex: Int

    var body: some View {
        ForEach(team.members.indexed(),
                id: \.index) { memberIndex, member in
            TextField("メンバー名を入力",
                      text: viewStore.binding(get: { _ in member.name },
                                              send: {
                .didChangedTextField(team: teamIndex,
                                     member: memberIndex,
                                     text: $0)
            })
            )
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
    }
}

// MARK: Private Methods
private extension NameFormsView {
    /// バリデーションエラーを表示すべきか判定する
    /// - Parameters:
    ///   - datas: バリデーションエラーの情報
    ///   - teamIndex: チームIndex
    ///   - memberIndex: メンバーIndex
    /// - Returns: true: 表示する / false: 表示しない
    func shouldShowValidationError(from datas: [InvalidTeamIndex],
                                   teamIndex: Int,
                                   memberIndex: Int) -> Bool {
        guard !datas.isEmpty else {
            return false
        }

        let data = datas.first(where: {
            ($0.team == teamIndex) && ($0.member == memberIndex)
        })

        return data != nil
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
        guard shouldShowValidationError(from: datas,
                                        teamIndex: teamIndex,
                                        memberIndex: memberIndex) else {
            return .clear
        }

        return AppColor.error.color
    }
}

// MARK: Previews
struct NameFormView_Previews: PreviewProvider {
    static var previews: some View {
        let state = TeamsMakeFeature.State(teamCount: 2)
        let viewStore = ViewStore(StoreOf<TeamsMakeFeature>(initialState: state,
                                                            reducer: TeamsMakeFeature()))
        NameFormsView(viewStore: viewStore,
                      team: TeamsMock().data[0],
                      teamIndex: 1)
    }
}
