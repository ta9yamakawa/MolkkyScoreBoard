//
//  TeamScore.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/11.
//

import Foundation

/// チームスコア
struct TeamScore: Identifiable, Hashable, Equatable {
    /// ID
    let id = UUID()
    /// 第何セットか
    let setNo: Int
    /// 得点
    var score: Int

    /// Initialize
    /// - Parameters:
    ///   - setNo: 何セット目か
    ///   - score: 得点
    init(setNo: Int, score: Int) {
        self.setNo = setNo
        self.score = score
    }

    /// Initialize
    /// - Parameter team: チーム情報
    init(from team: Team) {
        if let setNo = team.score.last?.setNo {
            self.setNo = setNo + 1
        } else {
            self.setNo = 1
        }

        self.score = .zero
    }
}
