//
//  TeamSelectButtonView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import SwiftUI

/// チーム選択ボタン
struct TeamSelectButtonView: View {

    /// チーム数
    let teamCount: Int

    var body: some View {
        Button(action: {
            print("tapped")
        }, label: {
            Text("\(teamCount)チーム")
                .font(Font.system(size: 20))
                .foregroundColor(.white)
        })
        .frame(width: 140)
        .padding(.vertical, 12)
        .background(Color.orange)
        .cornerRadius(4)
    }
}

// MARK: Previews
struct TeamSelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TeamSelectButtonView(teamCount: 1)
            .previewLayout(.sizeThatFits)
    }
}
