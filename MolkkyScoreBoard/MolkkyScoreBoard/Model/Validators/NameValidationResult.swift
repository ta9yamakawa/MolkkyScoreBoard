//
//  NameValidationResult.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/04.
//

/// 名前バリデーション結果の構造体
enum NameValidationResult: ValidationResult, Equatable {
    /// 成功
    case success
    /// 文字数上限に達した
    case maxLimitLength(Int)

    /// メッセージ
    var message: String {
        switch self {
        case .success:
            return ""

        case .maxLimitLength(let count):
            return "\(count)文字以内で入力してください"
        }
    }
}
