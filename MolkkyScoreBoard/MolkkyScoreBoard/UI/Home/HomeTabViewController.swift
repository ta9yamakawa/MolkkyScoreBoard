//
//  HomeTabViewController.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/05/05.
//

import SwiftUI

final class HomeTabViewController: UIViewController {

    static func instantiate() -> UIHostingController<HomeTabView> {
        let viewController = UIHostingController(rootView: HomeTabView())
        return viewController
    }
}
