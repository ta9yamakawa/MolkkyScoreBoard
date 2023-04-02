//
//  NameValidator.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/01.
//

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

/// 名前に関するバリデーション
struct NameValidator: Validator {

    /// 名前
    let name: String

    /// 検証を実施
    /// - Returns: NameValidationResult
    func validate() -> NameValidationResult {
        guard name.count < 10 else {
            return .maxLimitLength(10)
        }

        return .success
    }
}
