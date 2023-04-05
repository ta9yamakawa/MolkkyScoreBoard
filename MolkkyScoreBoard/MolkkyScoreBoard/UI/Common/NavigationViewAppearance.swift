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
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        appearance.configureWithOpaqueBackground()
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.backgroundColor = UIColor.systemGreen
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font : UIFont.boldSystemFont(ofSize: 20)]

        // ボタンの設定
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backButtonAppearance = backItemAppearance

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
