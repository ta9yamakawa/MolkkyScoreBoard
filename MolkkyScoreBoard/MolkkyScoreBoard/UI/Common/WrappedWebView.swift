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
    /// URL文字列
    var urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        return WKWebView(frame: .zero, configuration: config)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }

        uiView.load(URLRequest(url: url))
    }
}
