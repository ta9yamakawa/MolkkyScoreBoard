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
        case information = "情報"
    }

    /// 選択中のタブ
    @State private var selectedTab: TabType = .play

    /// Initialize
    init() {
        NavigationViewAppearance.configure()
        TabViewAppearance.configure()
    }

    var body: some View {
        DestinationHolderView() {
            TabView(selection: $selectedTab) {
                StartMenuView()
                    .tabItem {
                        Image("two-skittle")
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
