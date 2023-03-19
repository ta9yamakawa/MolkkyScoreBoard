//
//  TeamsMock.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/10.
//

import SwiftUI

/// チームデータのモック
struct TeamsMock {
    /// Data
    let data = [Team(id: 1,
                     members: [TeamMember(name: "hoge", order: 0)],
                     order: 0,
                     score: [TeamScore(setNo: 1, score: 50),
                             TeamScore(setNo: 2, score: 20),
                             TeamScore(setNo: 3, score: 0)]),
                Team(id: 2,
                     members: [TeamMember(name: "huga", order: 0)],
                     order: 1,
                     score: [TeamScore(setNo: 1, score: 20),
                             TeamScore(setNo: 2, score: 0),
                             TeamScore(setNo: 3, score: 50)]),
                Team(id: 3,
                     members: [TeamMember(name: "piyo", order: 0)],
                     order: 2,
                     score: [TeamScore(setNo: 1, score: 0),
                             TeamScore(setNo: 2, score: 50),
                             TeamScore(setNo: 3, score: 20)])]
}
