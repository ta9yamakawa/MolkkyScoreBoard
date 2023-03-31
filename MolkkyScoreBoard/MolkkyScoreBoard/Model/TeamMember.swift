//
//  TeamMember.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

import Foundation

/// チームメンバー
struct TeamMember: Identifiable, Hashable, Equatable {
    /// メンバーID
    let id = UUID()
    /// 名前
    var name: String
    /// プレイ順
    var order: Int
}
