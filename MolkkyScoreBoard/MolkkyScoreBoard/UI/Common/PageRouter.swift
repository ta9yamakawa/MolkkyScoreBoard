//
//  PageRouter.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/30.
//

import SwiftUI

/// ページルーター
final class PageRouter: ObservableObject {
    /// シングルトン
    static let shared = PageRouter()

    /// Path
    @Published var path = [DestinationType]()

    /// Initialize
    /// - Parameter path: [DestinationType]
    private init(path: [DestinationType] = []) {
        self.path = path
    }
}
