//
//  SpecialThanksRole.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/13.
//

/// スペシャルサンクスのメンバー
enum SpecialThanksRole: String, CaseIterable {
    /// デザイナー
    case designer = "デザイナー"
    /// アプリアイコン原案
    case appIconDraft = "アプリアイコン原案"
    /// その他サポーター
    case supporter = "サポーター"

    /// メンバー
    var members: [String] {
        switch self {
        case .designer:
            return ["hoge"]
        case .appIconDraft:
            return ["xxx", "yyy", "zzz"]
        case .supporter:
            return ["abc"]
        }
    }
}
