//
//  ResultTeamView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/23.
//

import SwiftUI
import ComposableArchitecture

/// 1チームあたりの結果 View
struct ResultTeamView: View {

    /// Team
    let team: Team

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text("\(team.ranking)")
                .font(Font.system(size: 14))
                .bold()
                .foregroundColor(AppColor.white.color)
                .padding(.all, 5)
                .background(AppColor.main.color)

            VStack(spacing: 5) {
                HStack {
                    Text("チーム\(team.id)")
                        .font(Font.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    Spacer()
                }

                HStack {
                    ForEach(team.members) { member in
                        let noName = "名無し"
                        let memberName = member.name.isEmpty ? noName : member.name
                        Text("\(memberName)さん ")
                    }
                    Spacer()
                }

                ForEach(team.score) { score in
                    HStack {
                        Text("第\(score.setNo)ゲーム：\(score.score)")
                        Spacer()
                    }
                }

                HStack {
                    Text("合計：\(team.totalScore())")
                        .font(Font.system(size: 20))
                        .bold()
                    Spacer()
                }
            }
        }
    }
}

// MARK: Previews
struct ResultTeamView_Previews: PreviewProvider {
    static var previews: some View {
        let members = [TeamMember(name: "hoge", order: 0),
                       TeamMember(name: "huga", order: 1),
                       TeamMember(name: "piyo", order: 2)]
        let team = Team(id: 1, members: members,
                        score: [TeamScore(setNo: 1,
                                          score: 50)])

        ResultTeamView(team: team)
    }
}
