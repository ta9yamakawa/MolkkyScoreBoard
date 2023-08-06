//
//  NavigationViewAppearance.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/15.
//

import SwiftUI

/// ナビゲーションビューの見た目の管理クラス
final class NavigationViewAppearance {

    /// Appearanceの設定
    static func configure() {
        // バーの設定
        let appearance = UINavigationBarAppearance()
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(AppColor.font.uiColor,
                                                                           renderingMode: .alwaysOriginal)
        appearance.configureWithOpaqueBackground()
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.backgroundColor = AppColor.main.uiColor
        appearance.titleTextAttributes = [.foregroundColor: AppColor.font.uiColor,
                                          .font : UIFont.boldSystemFont(ofSize: 20)]

        // ボタンの設定
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor : AppColor.font.uiColor]
        appearance.backButtonAppearance = backItemAppearance

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
