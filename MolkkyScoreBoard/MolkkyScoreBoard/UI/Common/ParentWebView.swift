//
//  ParentWebView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/11.
//

import SwiftUI

/// WebViewの親View
struct ParentWebView: View {
    /// URL
    private let url: String

    /// WebView
    private let webView: WrappedWebView

    /// Initialize
    /// - Parameter url: URL文字列
    init(url: String) {
        self.url = url
        self.webView = WrappedWebView(urlString: url)
    }

    var body: some View {
        VStack() {
            webView

            // ツールバーに値するパーツ
            HStack {
                Button(action: {
                    webView.goBack()
                }) {
                    Image(systemName: "chevron.backward")
                }
                .font(.title3)
                .padding(15)

                Button(action: {
                    webView.goForward()
                }) {
                    Image(systemName: "chevron.forward")
                        .font(.title3)
                        .padding(15)
                }

                Spacer()
            }
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
    }
}
