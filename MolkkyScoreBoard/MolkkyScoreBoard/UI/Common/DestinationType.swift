//
//  DestinationType.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/30.
//

/// 遷移先画面の種類
enum DestinationType: Hashable {
    /// チーム作成
    /// - Parameter: teamCount: チーム数
    case teamMake(teamCount: Int)
    /// プレイ順決定
    /// - Parameter: teams: 全チーム情報
    case teamOrderEdit(teams: [Team])
    /// プレイ
    /// - Parameter: teams: 全チーム情報
    case play(teams: [Team])
    /// 結果
    /// - Parameter: teams: 全チーム情報
    case result(teams: [Team])
}
