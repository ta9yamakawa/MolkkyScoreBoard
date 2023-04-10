//
//  WrappedWebView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/08.
//

import WebKit
import SwiftUI

/// UIKitで使うWKWebViewのラッパーView
struct WrappedWebView: UIViewRepresentable {
    var webView = WKWebView()
    var urlString: String

    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator

        webView.allowsBackForwardNavigationGestures = true

        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    /// 前のページに戻る
    func goBack() {
        webView.goBack()
    }

    /// 次のページに進む
    func goForward() {
        webView.goForward()
    }
}
