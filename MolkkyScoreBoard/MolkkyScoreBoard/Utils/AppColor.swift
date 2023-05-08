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
    /// エラーカラー
    case error

    /// カラーアセットの名前
    private var name: String {
        switch self {
        case .accent:
            return "accent"
        case .main:
            return "main"
        case .base:
            return "base"
        case .error:
            return "error"
        }
    }

    /// Color
    var color: Color {
        return Color(name)
    }

    /// UIColor
    var uiColor: UIColor {
        return UIColor(color)
    }
}
