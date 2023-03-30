//
//  HomeTabView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// ホーム画面
struct HomeTabView: View {

    // MARK: Enumerations
    /// タブの種類
    private enum TabType: String {
        case play = "プレイ"
        case information = "インフォメーション"
    }

    /// 選択中のタブ
    @State private var selectedTab: TabType = .play

    /// Router
    @StateObject private var router = PageRouter()

    /// Initialize
    init() {
        NavigationViewAppearance.configure()
        UITabBar.appearance().backgroundColor = .systemGray6
    }

    var body: some View {
        DestinationHolderView(router: router) {
            TabView(selection: $selectedTab) {
                StartMenuView(router: router)
                    .tabItem {
                        Image(systemName: "pencil.and.outline")
                        Text("プレイ")
                    }
                    .tag(TabType.play)
                
                InformationView()
                    .tabItem {
                        Image(systemName: "info.circle.fill")
                        Text("情報")
                    }
                    .tag(TabType.information)
            }
            .onChange(of: selectedTab) { tab in
                selectedTab = tab
            }
            .navigationTitle(selectedTab.rawValue)
        }
    }
}

// MARK: Private Methods
struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
