//
//  OrderingTeamView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/22.
//

import SwiftUI

/// 順番を入れ替える際のチームView
struct OrderingTeamView: View {

    /// チーム情報
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
private extension OrderingTeamView {
    /// チームメンバーの表示文
    /// - Parameter members: チームメンバー
    /// - Returns: チームメンバーの文字列
    func memberText(from members: [TeamMember]) -> String {
        guard let member = members.first else {
            return ""
        }

        let noName = "名無し"
        let memberName = member.name.isEmpty ? noName : member.name

        switch members.count {
        case 1:
            return "\(memberName)さん"

        case 2:
            let otherMember = members[1]
            let otherMemberName = otherMember.name.isEmpty ? noName : otherMember.name
            return "\(memberName)さんと\(otherMemberName)さん"

        case 3, 4:
            let otherMember = members[1]
            let otherMemberName = otherMember.name.isEmpty ? noName : otherMember.name
            return "\(memberName)さんと\(otherMemberName)さん 他"

        default:
            return ""
        }
    }
}

// MARK: Previews
struct OrderingTeamView_Previews: PreviewProvider {
    static var previews: some View {
        let members = [TeamMember(name: "hoge", order: 0),
                       TeamMember(name: "huga", order: 1),
                       TeamMember(name: "piyo", order: 2)]
        let team = Team(id: 1, members: members,
                        score: [TeamScore(setNo: 1,
                                          score: 50)])

        OrderingTeamView(team: team)
    }
}
