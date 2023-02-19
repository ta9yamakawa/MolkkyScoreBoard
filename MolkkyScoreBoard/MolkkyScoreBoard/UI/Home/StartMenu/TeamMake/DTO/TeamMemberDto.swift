//
//  TeamMemberDto.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

/// チームメンバー DTO
struct TeamMemberDto: Identifiable, Equatable {
    /// メンバーID
    let id: Int
    /// 名前
    var name: String
}
