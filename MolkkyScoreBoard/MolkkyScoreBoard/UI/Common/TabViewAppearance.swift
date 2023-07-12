//
//  TabViewAppearance.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/14.
//

import SwiftUI

/// ナビゲーションビューの見た目の管理クラス
final class TabViewAppearance {

    /// Appearanceの設定
    static func configure() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = AppColor.base.uiColor

        let normalColor = UIColor.systemGray2
        let selectedColor = AppColor.main.uiColor

        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: normalColor,
                                                             .font: UIFont.systemFont(ofSize: 10, weight: .medium)]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: selectedColor,
                                                                     .font: UIFont.systemFont(ofSize: 10, weight: .bold)]

        // 通常
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = textAttributes
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = normalColor
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor

        // iPad及びアイコンとラベルが横並びの場合
        tabBarAppearance.inlineLayoutAppearance.normal.titleTextAttributes = textAttributes
        tabBarAppearance.inlineLayoutAppearance.normal.iconColor = normalColor
        tabBarAppearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes
        tabBarAppearance.inlineLayoutAppearance.selected.iconColor = selectedColor

        // landscape表示の場合
        tabBarAppearance.compactInlineLayoutAppearance.normal.titleTextAttributes = textAttributes
        tabBarAppearance.compactInlineLayoutAppearance.normal.iconColor = normalColor
        tabBarAppearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedTextAttributes
        tabBarAppearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
