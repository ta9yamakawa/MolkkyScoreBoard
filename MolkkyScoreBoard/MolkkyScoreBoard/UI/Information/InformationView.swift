//
//  InformationView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// インフォメーション画面
struct InformationView: View {

    /// Web View Model
    private let webViewModel = ParentWebViewModel()

    var body: some View {
        List {
            Section {
                NavigationLink("モルック公式ルール", destination: {
                    ParentWebView(url: "https://molkky.jp/molkky/",
                                  viewModel: webViewModel)
                })

                NavigationLink("アプリ制作秘話", destination: {
                    ParentWebView(url: "https://note.com/present1206/n/ndcf826bbf70d",
                                  viewModel: webViewModel)
                })
                NavigationLink("Special Thanks", destination: {
                    SpecialThanksView()
                })
            }
            .listRowBackground(AppColor.bgList.color)

            Section {
                NavigationLink("プライバシーポリシー", destination: {
                    ParentWebView(url: "https://ta9yamakawa.github.io/MolkkyPrivacyPolicy/PrivacyPolicy/ja",
                                  viewModel: webViewModel)
                })
                Text("バージョン：\(AppVersion.currentVersion)")
            }
            .listRowBackground(AppColor.bgList.color)
        }
        .scrollContentBackground(.hidden)
        .background(AppColor.base.color)
    }
}

// MARK: Previews
struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
