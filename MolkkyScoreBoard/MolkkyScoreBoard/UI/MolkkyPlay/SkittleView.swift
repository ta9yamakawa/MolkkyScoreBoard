//
//  SkittleView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI

/// スキットル View
struct SkittleView: View {

    /// スキットルに記載される数（得点）
    let number: Int

    var body: some View {
        Button("\(number)") {
            // TODO: 選択と非選択のステータス変更をする
            print("Tap")
        }
        .frame(width: 20)
        .font(Font.system(size: 24))
        .bold()
        .foregroundColor(.white)
        .background(.blue)
        .clipShape(Circle())
    }
}

// Previews
struct SkittleView_Previews: PreviewProvider {
    static var previews: some View {
        SkittleView(number: 12)
    }
}
