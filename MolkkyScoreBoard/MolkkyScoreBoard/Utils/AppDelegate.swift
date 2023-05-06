//
//  AppDelegate.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/05/05.
//

import Foundation
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Window
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = HomeTabViewController.instantiate()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
