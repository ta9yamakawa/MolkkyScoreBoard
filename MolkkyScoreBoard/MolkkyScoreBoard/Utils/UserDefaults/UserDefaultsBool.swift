//
//  UserDefaultsBool.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/11/18.
//

import Foundation

/// UserDefaultsのBool型のデータの管理クラス
final class UserDefaultsBool {
    /// シングルトン
    static let shared = UserDefaultsBool()

    /// UserDefaults
    private let userDefaults = UserDefaults.standard

    /// Initialize
    private init() {}

    // MARK: Public Methods

    /// true/falseを更新する
    /// - Parameter key: UserDefaultsKeys
    func update(forKey key: UserDefaultsKeys, to newValue: Bool) {
        userDefaults.setValue(newValue, forKey: key.rawValue)
    }
    
    /// Bool値を取得する
    /// - Parameter key: UserDefaultsKeys
    /// - Returns: Bool
    func get(forKey key: UserDefaultsKeys) -> Bool {
        return userDefaults.bool(forKey: key.rawValue)
    }
}
