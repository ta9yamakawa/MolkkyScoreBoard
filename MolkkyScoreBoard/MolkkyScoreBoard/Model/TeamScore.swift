//
//  TeamScore.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/11.
//

/// チームスコア
struct TeamScore: Identifiable, Equatable {
    // FIXME: 適当に定義しているので見直す
    let id: Int = 0
    /// 第何セットか
    let setNo: Int
    /// 得点
    var score: Int
}
