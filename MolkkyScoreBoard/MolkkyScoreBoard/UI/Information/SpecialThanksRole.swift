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
    /// レビュアー
    case reviewer = "レビュアー"
    /// その他サポーター
    case supporter = "サポーター"

    /// メンバー
    var members: [String] {
        switch self {
        case .designer:
            return ["hoge"]
        case .reviewer:
            return ["xxx", "yyy", "zzz"]
        case .supporter:
            return ["abc"]
        }
    }
}
