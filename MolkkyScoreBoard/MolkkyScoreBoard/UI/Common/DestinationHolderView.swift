//
//  DestinationHolderView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/29.
//

import SwiftUI
import ComposableArchitecture

/// ページの遷移先を管理するRouter的なView
struct DestinationHolderView<Content:View>: View {

    /// Router
    @ObservedObject private var router: PageRouter

    /// 子ビュー
    private let content: Content

    /// Initialize
    /// - Parameters:
    ///   - router: PageRouter
    ///   - content: Content(ViewBuilder)
    init(router: PageRouter, @ViewBuilder content: () -> Content) {
        self.router = router
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content.navigationDestination(for: DestinationType.self) { destination in
                switch destination {
                case .teamMake(let teamCount):
                    TeamsMakeView(store: teamMakeStore(with: teamCount), router: router)
                        .navigationTitle(destination.navigationTitle)

                case .teamOrderEdit(let teams):
                    TeamsOrderEditView(store: orderEditStore(with: teams), router: router)
                        .navigationTitle(destination.navigationTitle)

                case .play(let teams):
                    MolkkyPlayView(store: playStore(with: teams), router: router)
                        .navigationTitle(destination.navigationTitle)

                case .result(let teams):
                    ResultView(store: resultStore(from: teams), router: router)
                        .navigationTitle(destination.navigationTitle)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(router)
    }
}

// MARK: Private Methods
private extension DestinationHolderView {
    /// チーム作成画面のStoreを取得
    /// - Parameter teamCount: チーム数
    /// - Returns: StoreOf<TeamsMakeFeature>
    func teamMakeStore(with teamCount: Int) -> StoreOf<TeamsMakeFeature> {
        let initialState = TeamsMakeFeature.State(teamCount: teamCount)
        return Store(initialState: initialState,
                     reducer: TeamsMakeFeature())
    }

    /// 順番入れ替え画面のStoreを取得
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<TeamsOrderEditFeature>
    func orderEditStore(with teams: [Team]) -> StoreOf<TeamsOrderEditFeature> {
        let initialState = TeamsOrderEditFeature.State(teams: teams)
        return Store(initialState: initialState,
                     reducer: TeamsOrderEditFeature())
    }

    /// モルックプレイ画面のStoreを取得
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<MolkkyPlayFeature>
    func playStore(with teams: [Team]) -> StoreOf<MolkkyPlayFeature> {
        let initialState = MolkkyPlayFeature.State(teams: teams)
        return Store(initialState: initialState,
                     reducer: MolkkyPlayFeature())
    }

    ///  結果画面のStoreを生成する
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<ResultFeature>
    func resultStore(from teams: [Team]) -> StoreOf<ResultFeature> {
        let state = ResultFeature.State(teams: teams)

        return Store(initialState: state,
                     reducer: ResultFeature())
    }
}
