//
//  TeamSelectButtonView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import SwiftUI
import ComposableArchitecture

/// チーム選択ボタン
struct TeamSelectButtonView: View {
    /// チーム数
    let teamCount: Int

    /// Router
    @ObservedObject var router: PageRouter

    var body: some View {
        Button("\(teamCount)チーム") {
            router.path.append(.teamMake(teamCount: teamCount))
        }
        .font(Font.system(size: 20))
        .foregroundColor(.white)
        .frame(width: 140)
        .padding(.vertical, 12)
        .background(Color.orange)
        .cornerRadius(4)
    }
}

// MARK: Previews
struct TeamSelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TeamSelectButtonView(teamCount: 1, router: PageRouter())
            .previewLayout(.sizeThatFits)
    }
}
