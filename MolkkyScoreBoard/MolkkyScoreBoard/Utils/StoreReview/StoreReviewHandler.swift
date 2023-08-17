//
//  StoreReviewHandler.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/08/17.
//

import Foundation

/// ストアレビューの判別管理クラス
final class StoreReviewHandler {

    // MARK: Constants

    /// シングルトン
    static let shared = StoreReviewHandler()

    /// User Defaults
    private let userDefaults = UserDefaults.standard

    /// 累計の起動回数（厳密にはプレイタブ表示回数）
    private static let totalLaunchCount = 20

    /// プレイ完了回数
    private static let totalPlayCompletedCount = 1

    /// Initialize
    private init() {}

    // MARK: Public Methods

    /// ストアの訴求をするかを判別する
    /// - Returns: true: する / false: しない
    func shouldRequest() -> Bool {
        let launchCountKey = UserDefaultsKeys.launchHomeCount.rawValue
        let playCompletedCountKey = UserDefaultsKeys.playCompletedCount.rawValue

        let launchCount = userDefaults.integer(forKey: launchCountKey)
        let playCompletedCount = userDefaults.integer(forKey: playCompletedCountKey)

        return launchCount >= type(of: self).totalLaunchCount || playCompletedCount == type(of: self).totalPlayCompletedCount
    }
}
