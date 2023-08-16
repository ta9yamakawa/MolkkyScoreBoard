//
//  StoreReviewHandler.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/08/17.
//

import Foundation

/// ストアレビューの判別管理クラス
final class StoreReviewHandler {

    /// シングルトン
    static let shared = StoreReviewHandler()

    private static let totalLaunchCount = 20

    private static let totalPlayCompletedCount = 1

    private let userDefaults = UserDefaults.standard

    /// Initialize
    private init() {}

    /// ストアの訴求をするかを判別する
    /// - Returns: true: する / false: しない
    func shouldRequest() -> Bool {
        let launchCountKey = UserDefaultsConstants.Key.launchHomeCount.rawValue
        let playCompletedCountKey = UserDefaultsConstants.Key.playCompletedCount.rawValue

        let launchCount = userDefaults.integer(forKey: launchCountKey)
        let playCompletedCount = userDefaults.integer(forKey: playCompletedCountKey)

        return launchCount >= type(of: self).totalLaunchCount || playCompletedCount == type(of: self).totalPlayCompletedCount
    }
}
