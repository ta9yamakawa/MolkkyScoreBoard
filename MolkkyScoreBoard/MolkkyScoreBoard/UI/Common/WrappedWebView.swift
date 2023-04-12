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
    typealias UIViewType = WKWebView

    /// Handler
    let setWebViewHandler: (WKWebView) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true

        setWebViewHandler(webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}
