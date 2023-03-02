//
//  TeamScoresView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI

/// 各チームのスコアView
struct TeamScoresView: View {
    var body: some View {
        let bounds = UIScreen.main.bounds
        HStack(alignment: .top, spacing: .zero) {
            VStack {
                Text("チーム")
                    .background(Color.orange)
                HStack {
                    Image(systemName: "arrow.right")
                    VStack(alignment: .leading, spacing: 5) {
                        Text("チーム名")
                            .multilineTextAlignment(.leading)
                        HStack {
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(Color.gray)
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(Color.gray)
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
            .frame(width: bounds.width / 2)
            .background(Color.blue)

            VStack {
                Text("前半")
            }
            .frame(width: bounds.width / 6)
            .background(Color.yellow)

            VStack {
                Text("後半")
            }
            .frame(width: bounds.width / 6)
            .background(Color.red)

            VStack {
                Text("合計")
            }
            .frame(width: bounds.width / 6)
            .background(Color.green)
        }
    }
}

struct TeamScoresView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoresView()
    }
}
