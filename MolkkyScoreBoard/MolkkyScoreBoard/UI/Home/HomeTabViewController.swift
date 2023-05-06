//
//  HomeTabViewController.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/05/05.
//

import SwiftUI

/// TabViewのHosting管理クラス
final class HomeTabViewController: UIViewController {

    /// Instantiate
    /// - Returns: UIHostingController<HomeTabView>
    static func instantiate() -> UIHostingController<HomeTabView> {
        let viewController = UIHostingController(rootView: HomeTabView())
        return viewController
    }
}
