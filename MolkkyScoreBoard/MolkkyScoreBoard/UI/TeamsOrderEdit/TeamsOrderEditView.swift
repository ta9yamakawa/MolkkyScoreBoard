//
//  TeamsOrderEditView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/21.
//

import SwiftUI

/// チームの順番決定画面
struct TeamsOrderEditView: View {

    let teams: [Team]

    var body: some View {
        Text("Hello, World!").onAppear(){
            print(teams)
        }
    }
}

// MARK: Previews
struct TeamsOrderEditView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(id: 1,
                          members: [TeamMember(name: "hoge")])]
        TeamsOrderEditView(teams: teams)
    }
}
