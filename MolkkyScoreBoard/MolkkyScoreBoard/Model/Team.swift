//
//  Team.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

/// チーム
struct Team: Identifiable, Equatable {
    /// チームID
    let id: Int
    /// チームメイト
    var members: [TeamMember]
    /// プレイ順
    var order = 0
    /// 前半の得点
    var firstHalfScore = 0
    /// 後半の得点
    var latterHalfScore = 0
    /// 連続失敗の回数
    var mistakeCount = 0
    /// 失格かどうか
    var isDisqualified = false
}
