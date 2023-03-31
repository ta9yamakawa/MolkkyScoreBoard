//
//  Validator.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/01.
//

/// バリデーション Protocol
protocol Validator {
    associatedtype ResultType: ValidationResult
    /// バリデーションを実施
    /// - Returns: ResultType
    func validate() -> ResultType
}
