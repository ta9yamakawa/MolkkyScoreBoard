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
            Text("\(team.order)")
                .font(Font.system(size: 14))
                .bold()
                .foregroundColor(Color.white)
                .padding(.all, 5)
                .background(Color.blue.cornerRadius(2))

            VStack(spacing: 5) {
                HStack {
                    Text("Team\(team.id)")
                        .font(Font.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    Spacer()
                }

                HStack {
                    ForEach(team.members) { member in
                        Text("\(member.name)さん ")
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
