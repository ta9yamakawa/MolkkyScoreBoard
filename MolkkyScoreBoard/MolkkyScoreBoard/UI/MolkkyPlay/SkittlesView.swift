//
//  SkittlesView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI

/// スキットルの配置 View
struct SkittlesView: View {
    var body: some View {
        VStack {
            HStack {
                SkittleView(number: 7)
                SkittleView(number: 9)
                SkittleView(number: 8)
            }

            HStack {
                SkittleView(number: 5)
                SkittleView(number: 11)
                SkittleView(number: 12)
                SkittleView(number: 6)
            }

            HStack {
                SkittleView(number: 3)
                SkittleView(number: 10)
                SkittleView(number: 4)
            }

            HStack {
                SkittleView(number: 1)
                SkittleView(number: 2)
            }
        }
    }
}

// MARK: Previews
struct SkittlesView_Previews: PreviewProvider {
    static var previews: some View {
        SkittlesView()
    }
}
