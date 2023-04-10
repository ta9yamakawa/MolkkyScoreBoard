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

    /// Coordinator
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        /// 親のWKWebView
        var parent: WKWebView

        /// Initiakize
        /// - Parameter parent: WKWebView
        init(_ parent: WKWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }

        // URLごとに処理を制御する
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url?.absoluteString {
                if (url.hasPrefix("https://apps.apple.com/")) {
                    guard let appStoreLink = URL(string: url) else {
                        return
                    }
                    UIApplication.shared.open(appStoreLink, options: [:], completionHandler: { (succes) in
                    })
                    decisionHandler(WKNavigationActionPolicy.cancel)
                } else if (url.hasPrefix("http")) {
                    decisionHandler(WKNavigationActionPolicy.allow)
                } else {
                    decisionHandler(WKNavigationActionPolicy.cancel)
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(webView)
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // makeCoordinatorで生成したCoordinatorクラスのインスタンスを指定
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
