//
//  InvalidTeamIndex.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/01.
//

/// バリデーションが通らなかったチームのインデックス情報
struct InvalidTeamIndex: Equatable {
    /// チーム
    let team: Int

    /// チームのメンバー
    let member: Int

    /// バリデーションエラーの種類
    let errorType: NameValidationResult?
}
