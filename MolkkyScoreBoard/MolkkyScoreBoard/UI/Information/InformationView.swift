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
                    ParentWebView(url: URLConstants.officialRule.rawValue,
                                  viewModel: webViewModel)
                })

                NavigationLink("アプリ制作秘話", destination: {
                    ParentWebView(url: URLConstants.developerNote.rawValue,
                                  viewModel: webViewModel)
                })
                NavigationLink("Special Thanks", destination: {
                    SpecialThanksView()
                })
            }
            .listRowBackground(AppColor.bgList.color)

            if let url = URL(string: URLConstants.appStore.rawValue) {
                Section {
                    Link("ストアでレビューを書く", destination: url)
                        .foregroundColor(.black)
                }
            }

            Section {
                NavigationLink("プライバシーポリシー", destination: {
                    ParentWebView(url: URLConstants.privacyPolicy.rawValue,
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
