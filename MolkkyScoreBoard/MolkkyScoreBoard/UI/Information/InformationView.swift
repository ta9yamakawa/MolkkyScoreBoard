//
//  InformationView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// インフォメーション画面
struct InformationView: View {

    var body: some View {
        List {
            Section {
                NavigationLink("モルック公式ルール", destination: {
                    ParentWebView(url: "https://molkky.jp/molkky/",
                                  viewModel: ParentWebViewModel())
                })

                // FIXME: 記事公開後にNavigationLinkにする
                VStack(spacing: 3) {
                    HStack {
                        Text("アプリ製作秘話")
                        Spacer()
                    }
                    HStack {
                        Text("※次バージョンで公開予定👷‍♂️").font(Font.system(size: 12))
                        Spacer()
                    }
                }

                NavigationLink("開発者への連絡", destination: {
                    Text("huga")
                })

                NavigationLink("Special Thanks", destination: {
                    SpecialThanksView()
                })
            }

            Section {
                NavigationLink("プライバシーポリシー", destination: {
                    ParentWebView(url: "https://ta9yamakawa.github.io/MolkkyPrivacyPolicy/PrivacyPolicy/ja",
                                  viewModel: ParentWebViewModel())
                })
                Text("バージョン：\(AppVersion.currentVersion)")
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
