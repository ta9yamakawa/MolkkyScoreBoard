//
//  TeamMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import SwiftUI
import ComposableArchitecture

/// チーム作成画面
struct TeamMakeView: View {

    /// チーム数
    let teamCount: Int

    var body: some View {
        Text("TeamMakeView: \(teamCount)")
    }
}

struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        TeamMakeView(teamCount: 1)
    }
}
