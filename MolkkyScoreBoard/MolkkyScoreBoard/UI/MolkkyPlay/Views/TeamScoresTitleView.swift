//
//  TeamScoresTitleView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/04.
//

import SwiftUI

/// チームスコアのタイトルView
struct TeamScoresTitleView: View {
    var body: some View {
        let bounds = UIScreen.main.bounds

        HStack(spacing: .zero) {
            Text("チーム")
                .frame(width: bounds.width / 2)
            Text("前半")
                .frame(width: bounds.width / 6)
            Text("後半")
                .frame(width: bounds.width / 6)
            Text("合計")
                .frame(width: bounds.width / 6)
        }
        .padding(.vertical, 8)
        .background(Color.orange)
    }
}

// MARK: Previews
struct TeamScoresTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoresTitleView()
    }
}
