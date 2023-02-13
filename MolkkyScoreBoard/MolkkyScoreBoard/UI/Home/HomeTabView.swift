//
//  HomeTabView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// ホーム画面
struct HomeTabView: View {

    enum Tabs: String {
        case play = "プレイ"
        case information = "インフォメーション"
    }

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.systemGreen
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                       .font : UIFont.boldSystemFont(ofSize: 20)]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance

        UITabBar.appearance().backgroundColor = .systemGray6
    }

    @State private var navigationTitle: String = Tabs.play.rawValue
    @State private var selectedTab: Tabs = .play

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                StartMenuView()
                    .tabItem {
                        Image(systemName: "pencil.and.outline")
                        Text("プレイ")
                    }.tag(Tabs.play)

                InformationView()
                    .tabItem {
                        Image(systemName: "info.circle.fill")
                        Text("情報")
                    }.tag(Tabs.information)
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: selectedTab) { tab in
                navigationTitle = selectedTab.rawValue
            }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
