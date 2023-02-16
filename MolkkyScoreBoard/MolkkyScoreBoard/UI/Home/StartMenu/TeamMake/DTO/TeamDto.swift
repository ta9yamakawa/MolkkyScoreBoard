//
//  TeamDto.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

/// チーム DTO
struct TeamDto: Equatable {
    /// チームID
    let id: Int
    /// チームメイト
    let members: [TeamDto]
}
