//
//  ParentWebViewModel.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/12.
//

import Foundation
import Combine
import WebKit

final class ParentWebViewModel: ObservableObject {
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false

    private weak var webView: WKWebView?
    private var cancellables = Set<AnyCancellable>()

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

    func initialLoad(to url: String) {
        guard let url = URL(string: url) else {
            return
        }
        webView?.load(URLRequest(url: url))
    }

    func goBack() {
        if canGoBack {
            webView?.goBack()
        }
    }

    func goForward() {
        if canGoForward {
            webView?.goForward()
        }
    }

    func reload() {
        webView?.reload()
    }
}
