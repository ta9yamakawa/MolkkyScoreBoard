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
                    WrappedWebView(urlString: "https://molkky.jp/molkky/")
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

                NavigationLink("開発者への連絡はこちら", destination: {
                    Text("huga")
                })

                NavigationLink("Special Thanks", destination: {
                    Text("huga")
                })


            }

            Section {
                NavigationLink("プライバシーポリシー", destination: {
                    Text("hoge")
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
