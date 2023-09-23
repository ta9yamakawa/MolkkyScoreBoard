//
//  PlayAction.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/14.
//

/// プレイ時のチームごとのアクションのデータ
struct PlayAction: Equatable {
    /// チーム
    let teams: [Team]
    /// プレイ順
    let playingOrder: Int
}
