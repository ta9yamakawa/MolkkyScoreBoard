//
//  HomeTabView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// ホーム画面
struct HomeTabView: View {

    init() {
        UITabBar.appearance().backgroundColor = .systemGray6
    }

    var body: some View {
        TabView {
            StartMenuView()
                .tabItem {
                    Image(systemName: "pencil.and.outline")
                    Text("プレイ")
                }

            InformationView()
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("情報")
                }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
