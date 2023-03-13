//
//  PlayActionUndoManager.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/14.
//

import Foundation
import ComposableArchitecture

final class PlayActionUndoManager {
    /// シングルトン
    static let shared = PlayActionUndoManager()

    /// Undo Manager
    private let manager = UndoManager()

    private(set) var actions = [PlayAction]()

    private init() {}

    func add(_ action: PlayAction) {
        actions.append(action)
//        registerOperation(.add(action))
    }

    func delete(_ action: PlayAction) {
        guard !actions.isEmpty else {
            return
        }

        actions.removeLast()
//        registerOperation(.delete(action))
    }
}
