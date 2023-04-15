//
//  PageRouter.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/30.
//

import SwiftUI

/// ページルーター
final class PageRouter: ObservableObject, Equatable {
    /// Path
    @Published var path = [DestinationType]()

    static func == (lhs: PageRouter, rhs: PageRouter) -> Bool {
        return lhs.path == rhs.path
    }
}
