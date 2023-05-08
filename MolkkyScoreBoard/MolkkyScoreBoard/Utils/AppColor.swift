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
    // MARK: アクセント系カラー
    /// 赤
    case accent
    /// オレンジ
    case accent2
    /// 肌色
    case accent3

    /// メインカラー
    case main
    /// ベースカラー
    case base
    /// エラーカラー
    case error
    /// スキットルの色
    case skittle
    /// キャンセル系カラー
    case cancel
    /// フォントカラー
    case font
    /// 白色
    case white
    /// 薄めの青
    case lightBlue

    /// カラーアセットの名前
    private var name: String {
        switch self {
        case .accent:
            return "accent"
        case .accent2:
            return "accent2"
        case .accent3:
            return "accent3"
        case .main:
            return "main"
        case .base:
            return "base"
        case .error:
            return "error"
        case .skittle:
            return "skittle"
        case .cancel:
            return "cancel"
        case .font:
            return "font"
        case .white:
            return "white"
        case .lightBlue:
            return "lightBlue"
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
