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
        let team = viewStore.state.teams[index]

        GeometryReader { geometry in
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor(viewStore.state.playingOrder == index ? .black : .clear)
                        .padding(.leading, 25)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("チーム\(team.id)")
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 12))

                        Text("\(memberName(from: team))さん")
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .font(Font.system(size: 16))

                        HStack(spacing: 5) {
                            ForEach (1..<4) { count in
                                Circle()
                                    .frame(width: 18)
                                    .foregroundColor(circleColor(from: team,
                                                                 count: count))
                            }
                        }
                    }

                    Spacer()

                }
                .frame(width: geometry.size.width / 2)

                Text("\(team.score.last?.score ?? 0)")
                    .frame(width: geometry.size.width / 4)

                Text("\(team.totalScore())")
                    .frame(width: geometry.size.width / 4)
            }
            .frame(height: 70)
            .padding(.top, 10)
        }
        .frame(height: 80)
    }
}

// MARK: Private Methods
private extension TeamScoresRowView {
    /// 円の色を取得する
    /// - Parameters:
    ///   - team: Team
    ///   - count: 得点の上限
    /// - Returns: 円の色
    func circleColor(from team: Team, count: Int) -> Color {
        let isMistake = team.mistakeCount < count
        return isMistake ? AppColor.cancel.color : AppColor.error.color
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
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<MolkkyPlayFeature>(initialState: state,
                                                             reducer: MolkkyPlayFeature()))
        TeamScoresRowView(viewStore: viewStore, index: 0)
    }
}
