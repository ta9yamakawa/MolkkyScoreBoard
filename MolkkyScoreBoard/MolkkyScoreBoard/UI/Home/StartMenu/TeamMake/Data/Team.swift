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
}
