//
//  StartMenuView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI
import StoreKit

/// プレイスタート画面
struct StartMenuView: View {

    /// ストアレビュー訴求用
    @Environment(\.requestReview) private var requestReview

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

            Divider()

            ModeSwitchView()

            Spacer()
        }
        .onAppear(perform: {
            UserDefaultsInteger.shared.increment(forKey: .launchHomeCount)
            requestStoreReview()
        })
        .background(AppColor.base.color)
    }
}

// MARK: Private Methods
private extension StartMenuView {
    /// ストアレビューを訴求する
    func requestStoreReview() {
        guard StoreReviewHandler.shared.shouldRequest() else {
            return
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            requestReview()
        }
    }
}

private struct ModeSwitchView: View {

    @State private var isPartyMode = UserDefaultsBool.shared.get(forKey: .isPartyMode)

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("パーティモード")
                    .font(.system(size: 16))
                Text("投げるたびにランダムでお題が変わります。\n息抜きにプレイしたい時に！")
                    .font(.system(size: 12))
                    .lineLimit(2)
            }

            Toggle("", isOn: $isPartyMode)
                .labelsHidden()
                .tint(AppColor.accent2.color)
                .onChange(of: isPartyMode) { newValue in
                    UserDefaultsBool.shared.update(forKey: .isPartyMode,
                                                   to: newValue)
                }
        }
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
