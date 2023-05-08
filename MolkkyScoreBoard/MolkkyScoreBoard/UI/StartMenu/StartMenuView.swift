//
//  StartMenuView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// プレイスタート画面
struct StartMenuView: View {

    /// 最小チーム数
    private let minTeamCount = 1

    /// 最大チーム数
    private let maxTeamCount = 6

    /// GridItem
    private static let gridItem = GridItem(.flexible(minimum: 140, maximum: 180))

    /// Columns
    private let columns = Array(repeating: gridItem, count: 2)

    var body: some View {
        VStack(spacing: 30) {
            IntroductionTextView(message: "何チームでモルックをプレイしますか？")

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach((minTeamCount...maxTeamCount),
                        id: \.self) { teamCount in
                    TeamSelectButtonView(teamCount: teamCount)
                }
            }

            Spacer()
        }
        .background(AppColor.base.color)
    }
}

// MARK: Previews
struct StartMenuView_Previews: PreviewProvider {
    static var previews: some View {

        ForEach(["iPhone SE (3rd generation)",
                 "iPad Pro (12.9-inch) (6th generation)",
                 "iPhone 14"],
                id: \.self) { deviceName in
            StartMenuView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
