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
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                Text("チーム")
                    .frame(width: geometry.size.width / 2)
                Text("セット")
                    .frame(width: geometry.size.width / 4)
                Text("合計")
                    .frame(width: geometry.size.width / 4)
            }
            .frame(height: 40)
            .background(Color.orange)
        }
        .frame(height: 40)
    }
}

// MARK: Previews
struct TeamScoresTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoresTitleView()
    }
}
