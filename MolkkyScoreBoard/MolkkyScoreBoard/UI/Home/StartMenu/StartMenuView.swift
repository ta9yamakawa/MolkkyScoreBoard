//
//  StartMenuView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// プレイスタート画面
struct StartMenuView: View {

    /// 最小チーム数
    private static let minTeamCount = 1

    /// 最大チーム数
    private static let maxTeamCount = 6

    /// GridItem
    private static let gridItem = GridItem(.flexible(minimum: 140, maximum: 180))

    /// Columns
    private var columns = Array(repeating: gridItem, count: 2)

    var body: some View {
        VStack(spacing: 30) {
            Text("何チームでモルックを\nプレイしますか？")
                .font(Font.system(size: 20))
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach((type(of: self).minTeamCount...type(of: self).maxTeamCount), id: \.self) { index in
                    Button(action: {
                        print("tapped")
                    }, label: {
                        Text("\(index)チーム")
                            .font(Font.system(size: 20))
                            .foregroundColor(.white)
                    })
                    .frame(width: 140)
                    .padding(.vertical, 12)
                    .background(Color.orange)
                    .cornerRadius(4)
                }
            }

            Spacer()
        }
    }
}

struct StartMenuView_Previews: PreviewProvider {
    static var previews: some View {

        ForEach(["iPhone SE (3rd generation)",
                 "iPad Pro (12.9-inch) (6th generation)",
                 "iPhone 14"],
                id: \.self) { deviceName in
            StartMenuView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
