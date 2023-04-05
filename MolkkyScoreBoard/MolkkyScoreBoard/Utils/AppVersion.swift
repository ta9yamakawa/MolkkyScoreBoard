//
//  AppVersion.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/06.
//

import Foundation

/// アプリバージョンのデータクラス
final class AppVersion {
    /// 現在のバージョン
    static let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}
