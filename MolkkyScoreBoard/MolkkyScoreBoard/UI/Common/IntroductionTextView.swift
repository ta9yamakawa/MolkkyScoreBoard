//
//  IntroductionTextView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/30.
//

import SwiftUI

/// 説明文のView
struct IntroductionTextView: View {

    let message: String

    let annotation: String?

    init(message: String, annotation: String? = nil) {
        self.message = message
        self.annotation = annotation
    }

    var body: some View {
        VStack(spacing: 5) {
            Text(message)
                .font(Font.system(size: 18))

            if let annotation = annotation {
                Text(annotation)
                    .font(.footnote)
            }
        }
        .padding(.top, 20)
    }
}

struct IntroductionTextView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionTextView(message: "ここにメッセージを表示します",
                             annotation: "ここで注釈を表示します")
    }
}
