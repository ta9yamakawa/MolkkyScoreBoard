//
//  PageRouter.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/30.
//

import SwiftUI

/// ページルーター
final class PageRouter: ObservableObject {
    /// Path
    @Published var path = [DestinationType]()
}
