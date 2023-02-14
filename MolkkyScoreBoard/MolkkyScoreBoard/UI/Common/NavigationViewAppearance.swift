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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGreen
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font : UIFont.boldSystemFont(ofSize: 20)]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
