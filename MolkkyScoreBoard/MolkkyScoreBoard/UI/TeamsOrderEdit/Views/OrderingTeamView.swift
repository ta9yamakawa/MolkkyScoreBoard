//
//  OrderingTeamView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/22.
//

import SwiftUI

/// 順番を入れ替える際のチームView
struct OrderingTeamView: View {

    let team: Team

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Team\(team.id)")
                    .font(Font.system(size: 24))
                    .fontWeight(.bold)
                Spacer()
            }

            HStack {
                Text(memberText(from: team.members))
                Spacer()
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

// MARK: Previews
struct OrderingTeamView_Previews: PreviewProvider {
    static var previews: some View {
        let members = [TeamMember(name: "hoge"),
                       TeamMember(name: "huga"),
                       TeamMember(name: "piyo")]
        let team = Team(id: 1, members: members)

        OrderingTeamView(team: team)
    }
}
