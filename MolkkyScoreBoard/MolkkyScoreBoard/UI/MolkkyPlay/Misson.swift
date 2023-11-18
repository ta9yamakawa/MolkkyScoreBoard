//
//  Misson.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/11/12.
//

import Foundation

/// パーティモードのお題
enum Mission: String, CaseIterable {
    case normal = "いつも通り投げて"
    case bothHands = "両手で投げて！"
    case closeEyes = "目を閉じて投げて！"
    case nondominanntHand = "利き手と逆の手で投げて！"
    case backwards = "後ろ向きに投げて！"
    case standingOneLeg = "片足立ちで投げて！"
    case suddenDeath = "ミスしたら失格"
}
