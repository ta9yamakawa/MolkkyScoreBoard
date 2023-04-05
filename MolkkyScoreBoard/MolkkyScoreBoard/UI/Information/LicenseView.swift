//
//  LicenseViewHelper.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/06.
//

import Foundation
import AcknowList
import SwiftUI

struct LicenseView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AcknowListViewController

    func makeUIViewController(context: Context) -> AcknowListViewController {
        guard let url = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
              let data = try? Data(contentsOf: url),
              let acknowList = try? AcknowPackageDecoder().decode(from: data) else {
            assertionFailure("Failed load package...")
            return AcknowListViewController()
        }

        let viewController = AcknowListViewController()
        viewController.acknowledgements = acknowList.acknowledgements
        return viewController
    }

    func updateUIViewController(_ uiViewController: AcknowListViewController, context: Context) {
        // Not Needed.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
    }
}

