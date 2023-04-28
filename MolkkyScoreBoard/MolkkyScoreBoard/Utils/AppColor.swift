//
//  AppColor.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/14.
//

import Foundation
import SwiftUI

/// アプリ内で使うカラー定義
enum AppColor {
    /// アクセントカラー
    case accent
    /// メインカラー
    case main
    /// ベースカラー
    case base

    /// カラーアセットの名前
    private var name: String {
        switch self {
        case .accent:
            return "accent"
        case .main:
            return "main"
        case .base:
            return "base"
        }
    }

    /// Color
    var color: Color {
        return Color(name)
    }

    var uiColor: UIColor {
        return UIColor(color)
    }
}
