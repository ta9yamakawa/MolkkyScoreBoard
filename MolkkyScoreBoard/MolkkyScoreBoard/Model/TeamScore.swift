//
//  TeamScore.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/11.
//

import Foundation

/// チームスコア
struct TeamScore: Identifiable, Equatable {
    /// ID
    let id = UUID()
    /// 第何セットか
    let setNo: Int
    /// 得点
    var score: Int
}
