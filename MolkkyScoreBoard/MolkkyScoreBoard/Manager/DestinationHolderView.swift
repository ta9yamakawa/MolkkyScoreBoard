//
//  DestinationHolderView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/29.
//

import SwiftUI
import ComposableArchitecture

enum DestinationViewType: Hashable {
    case teamMake(teamCount: Int)
    case teamOrderEdit(teams: [Team])
}

final class PageRouter: ObservableObject {
    @Published var path = NavigationPath()
}

struct DestinationHolderView<Content:View>: View {
    @ObservedObject var router: PageRouter
    let content: Content

    init(router: PageRouter, @ViewBuilder content: () -> Content) {
        self.router = router
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: DestinationViewType.self) { // - 2
                    destination in
                    switch destination {
                    case .teamMake(let teamCount):
                        TeamsMakeView(router: router, store: store(with: teamCount))

                    case .teamOrderEdit(let teams):
                        TeamsOrderEditView(store: store(teams: teams), router: router)
                    }
                }
                .navigationTitle("huga")
                .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(router)
    }
}

// MARK: Private Methods
private extension DestinationHolderView {
    /// Storeを取得
    /// - Parameter teamCount: チーム数
    /// - Returns: StoreOf<TeamsMakeFeature>
    func store(with teamCount: Int) -> StoreOf<TeamsMakeFeature> {
        let initialState = TeamsMakeFeature.State(teamCount: teamCount)
        return Store(initialState: initialState,
                     reducer: TeamsMakeFeature())
    }

    /// Storeを取得
    /// - Parameter teams: チーム情報
    /// - Returns: StoreOf<TeamsOrderEditFeature>
    func store(teams: [Team]) -> StoreOf<TeamsOrderEditFeature> {
        let initialState = TeamsOrderEditFeature.State(teams: teams)
        return Store(initialState: initialState,
                     reducer: TeamsOrderEditFeature())
    }
}
