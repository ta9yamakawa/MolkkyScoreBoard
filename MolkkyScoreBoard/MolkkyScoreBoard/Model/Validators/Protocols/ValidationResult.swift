//
//  ValidationResult.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/01.
//

/// バリデーションの結果 Protocol
protocol ValidationResult {
    /// バリデーション成功
    var isValid: Bool { get }
}
