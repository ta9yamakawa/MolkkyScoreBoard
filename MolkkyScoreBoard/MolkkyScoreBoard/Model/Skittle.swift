//
//  Skittle.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/04.
//

/// スキットル
struct Skittle: Equatable {
    /// スキットルに書かれた数
    private(set) var number: Int

    /// 上限の数
    private static let overNumber = 13

    /// Initialize
    /// - Parameter number: スキットルに書かれた数
    init(number: Int) {
        guard number > 0 && number < type(of: self).overNumber else {
            fatalError("Illegal state")
        }

        self.number = number
    }
}
