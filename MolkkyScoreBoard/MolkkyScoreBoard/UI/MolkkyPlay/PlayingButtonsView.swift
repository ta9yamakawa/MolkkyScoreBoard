//
//  PlayingButtonsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/03.
//

import SwiftUI

/// モルックプレイ中のボタンに関するView
struct PlayingButtonsView: View {
    var body: some View {
        HStack() {
            Button("戻る") {
                // TODO: 一個前に戻る処理を書く
                print("undo")
            }
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 40)
            .background(Color.gray)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 10,
                                bottom: 0,
                                trailing: 0))

            Spacer()

            Button("決定") {
                // 次の人のターンに行く処理を書く
                print("undo")
            }
            .font(Font.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 80, height: 40)
            .background(Color.orange)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))

        }
    }
}

// MARK: Previews
struct PlayingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingButtonsView()
    }
}
