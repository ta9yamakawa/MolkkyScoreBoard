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

    var body: some View {
        Button(action: {
            PageRouter.shared.path.append(.teamMake(teamCount: teamCount))
        },
               label: {
            Text("\(teamCount)チーム")
                .font(Font.system(size: 20))
                .frame(width: 130)
                .padding(.vertical, 12)
        })
        .foregroundColor(.white)
        .background(AppColor.main.color)
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
