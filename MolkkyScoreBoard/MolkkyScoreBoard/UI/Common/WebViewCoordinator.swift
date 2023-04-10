//
//  WebViewCoordinator.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/11.
//

import WebKit

/// Coordinator
class WebViewCoordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }

    // URLごとに処理を制御する
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url?.absoluteString else {
            return
        }

        if url.hasPrefix("http") {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
}
