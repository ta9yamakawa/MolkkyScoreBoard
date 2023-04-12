//
//  ParentWebViewModel.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/12.
//

import Foundation
import Combine
import WebKit

/// 親のWebView ViewModel
final class ParentWebViewModel: ObservableObject {
    /// 一つ前に戻れるかどうか
    @Published var canGoBack: Bool = false

    /// 一つ先に進めるかどうか
    @Published var canGoForward: Bool = false

    /// WebView
    private weak var webView: WKWebView?

    /// Cancellables
    private var cancellables = Set<AnyCancellable>()

    /// WebViewの準備
    /// - Parameter webView: WKWebView
    func setWebView(_ webView: WKWebView) {
        self.webView = webView

        webView.publisher(for: \.canGoBack)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoBack = value
            }
            .store(in: &cancellables)

        webView.publisher(for: \.canGoForward)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoForward = value
            }
            .store(in: &cancellables)
    }

    /// 遷移直後の画面の読み込み
    /// - Parameter url: URL文字列
    func initialLoad(to url: String) {
        guard let url = URL(string: url) else {
            return
        }
        webView?.load(URLRequest(url: url))
    }

    /// 一つ前に戻る
    func goBack() {
        guard canGoBack else {
            return
        }
        webView?.goBack()
    }

    /// 一つ先に進む
    func goForward() {
        guard canGoForward else {
            return
        }
        webView?.goForward()
    }
}
