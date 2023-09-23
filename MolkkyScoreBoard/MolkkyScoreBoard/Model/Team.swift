//
//  Team.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/17.
//

/// チーム
struct Team: Identifiable, Hashable {
    /// チームID
    let id: Int
    /// チームメイト
    var members: [TeamMember]
    /// チームのプレイ順
    var order = 0
    /// メンバーのプレイ順
    var memberOrder = 0
    /// 得点
    var score: [TeamScore] = []
    /// 連続失敗の回数
    var mistakeCount = 0
    /// 失格かどうか
    var isDisqualified = false
    /// ランキング
    var ranking: Int = 0

    /// 合計点を取得する
    /// - Returns: 合計点
    func totalScore() -> Int {
        let totalScore = score.map {
            $0.score
        }.reduce(0, +)
        return totalScore
    }
    
    /// 次の試合に向けたチームのデータを作成する
    /// - Returns: リセットされたチームデータ
    func teamForNextMatch() -> Team {
        var newTeam = self
        let newScore = TeamScore(from: self)
        newTeam.score.append(newScore)

        // 失敗回数と失格になったかのフラグをリセットする
        newTeam.mistakeCount = .zero
        newTeam.isDisqualified = false

        return newTeam
    }
}
