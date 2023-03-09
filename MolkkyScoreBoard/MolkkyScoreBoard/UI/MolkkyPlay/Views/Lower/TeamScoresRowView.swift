//
//  TeamScoresRowView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/09.
//

import SwiftUI
import ComposableArchitecture

/// 一つのチームの行View
struct TeamScoresRowView: View {

    /// View Store
    let viewStore: ViewStore<MolkkyPlayFeature.State,
                             MolkkyPlayFeature.Action>

    /// Index
    let index: Int

    var body: some View {
        let bounds = UIScreen.main.bounds
        let team = viewStore.state.teams[index]

        HStack {
            HStack(spacing: 20) {
                if viewStore.state.playingOrder == index {
                    Image(systemName: "arrow.right")
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("チーム\(team.id)")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 10))

                    Text("\(memberName(from: team))さん")
                        .multilineTextAlignment(.leading)
                        .bold()

                    HStack(spacing: 5) {
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(circleColor(from: viewStore.state.teams[index],
                                                         count: 1))
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(circleColor(from: viewStore.state.teams[index],
                                                         count: 2))
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(circleColor(from: viewStore.state.teams[index],
                                                         count: 3))
                    }
                }
            }
            .frame(width: bounds.width / 2)

            Text("\(viewStore.state.teams[index].firstHalfScore)")
                .frame(width: bounds.width / 6)

            Text("\(viewStore.state.teams[index].latterHalfScore)")
                .frame(width: bounds.width / 6)

            Text("\(totalScore(from: viewStore.state.teams[index]))")
                .frame(width: bounds.width / 6)
        }
        .padding(.top, 10)
    }
}

// MARK: Private Methods
private extension TeamScoresRowView {
    /// 合計点を取得する
    /// - Parameter team: Team
    /// - Returns: 合計点
    func totalScore(from team: Team) -> Int {
        return team.firstHalfScore + team.latterHalfScore
    }

    /// 円の色を取得する
    /// - Parameters:
    ///   - team: Team
    ///   - count: 得点の上限
    /// - Returns: 円の色
    func circleColor(from team: Team, count: Int) -> Color {
        return team.mistakeCount < count ? .gray : .red
    }

    /// チームメンバーの名前を取得する
    /// - Parameter team: Team
    /// - Returns: メンバーの名前
    func memberName(from team: Team) -> String {
        // 取得できない or メンバー名が空なら「名無し」にする
        if
            let member = team.members.first(where: { $0.order == team.memberOrder}),
            !member.name.isEmpty {
            return member.name
        } else {
            return "名無し"
        }
    }
}


// MARK: Previews
struct TeamScoresRowView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data,
                                            isLatterHalf: false)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        TeamScoresRowView(viewStore: viewStore, index: 0)
    }
}
