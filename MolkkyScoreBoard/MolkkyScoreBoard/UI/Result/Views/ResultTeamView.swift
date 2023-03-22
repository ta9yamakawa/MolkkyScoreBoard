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
                    Text(memberText(from: team.members))
                    Spacer()
                }
            }
        }
    }
}

// MARK: Private Methods
private extension ResultTeamView {
    /// チームメンバーの表示文
    /// - Parameter members: チームメンバー
    /// - Returns: チームメンバーの文字列
    func memberText(from members: [TeamMember]) -> String {
        guard let member = members.first else {
            return ""
        }

        switch members.count {
        case 1:
            return "\(member.name)さん"

        case 2:
            let otherMember = members[1]
            return "\(member.name)さんと\(otherMember.name)さん"

        case 3, 4:
            let otherMember = members[1]
            return "\(member.name)さんと\(otherMember.name)さん 他"

        default:
            return ""
        }
    }
}

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
