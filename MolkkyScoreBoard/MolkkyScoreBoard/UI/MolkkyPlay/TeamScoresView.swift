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
        VStack(spacing: 10) {
            HStack(spacing: .zero) {
                Text("チーム")
                    .frame(width: bounds.width / 2)
                Text("前半")
                    .frame(width: bounds.width / 6)
                Text("後半")
                    .frame(width: bounds.width / 6)
                Text("合計")
                    .frame(width: bounds.width / 6)
            }
            .padding(.vertical, 8)
            .background(Color.orange)

            HStack {
                HStack(spacing: 20) {
                    Image(systemName: "arrow.right")
                    VStack(alignment: .leading, spacing: 5) {
                        Text("チーム名")
                            .multilineTextAlignment(.leading)
                        HStack(spacing: 5) {
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
                .frame(width: bounds.width / 2)

                Text("0")
                    .frame(width: bounds.width / 6)

                Text("0")
                    .frame(width: bounds.width / 6)
                
                Text("0")
                    .frame(width: bounds.width / 6)
            }

            Divider()
        }
    }
}

struct TeamScoresView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoresView()
    }
}
