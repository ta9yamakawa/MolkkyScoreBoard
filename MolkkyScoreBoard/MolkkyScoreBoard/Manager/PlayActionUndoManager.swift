//
//  PlayActionUndoManager.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/14.
//

import ComposableArchitecture

/// プレイを記録してUndoを管理するクラス
final class PlayActionUndoManager {
    /// プレイデータ
    private(set) var actions = [PlayAction]()

    /// 追加
    /// - Parameter action: PlayAction
    func add(_ action: PlayAction) {
        actions.append(action)
    }

    /// 削除
    /// - Parameter action: PlayAction
    func delete(_ action: PlayAction) {
        guard !actions.isEmpty else {
            return
        }

        actions.removeLast()
    }
}
