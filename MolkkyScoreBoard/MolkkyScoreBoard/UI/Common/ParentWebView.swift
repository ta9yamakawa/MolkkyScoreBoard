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
    let url: String

    /// ViewModel
    @StateObject var viewModel: ParentWebViewModel

    var body: some View {
        VStack() {
            WrappedWebView(setWebViewHandler: { webView in
                viewModel.setWebView(webView)
            })

            // ツールバーに値するパーツ
            HStack {
                Button(action: {
                    viewModel.goBack()
                }) {
                    Image(systemName: "chevron.backward")
                }
                .font(.title3)
                .disabled(!viewModel.canGoBack)
                .padding(15)

                Button(action: {
                    viewModel.goForward()
                }) {
                    Image(systemName: "chevron.forward")
                }
                .font(.title3)
                .disabled(!viewModel.canGoForward)
                .padding(15)

                Spacer()
            }
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
        .onAppear {
            viewModel.initialLoad(to: url)
        }
    }
}
