//
//  UserDefaultsInteger.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/08/17.
//

import Foundation

/// UserDefaultsのInt型のデータの管理クラス
final class UserDefaultsInteger {
    /// シングルトン
    static let shared = UserDefaultsInteger()

    /// UserDefaults
    private let userDefaults = UserDefaults.standard

    /// Initialize
    private init() {}

    // MARK: Public Methods

    /// 加算する
    /// - Parameter key: UserDefaultsKeys
    func increment(forKey key: UserDefaultsKeys) {
        var value = userDefaults.integer(forKey: key.rawValue)
        value += 1

        userDefaults.setValue(value, forKey: key.rawValue)
    }
}
