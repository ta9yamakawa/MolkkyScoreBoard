//
//  TeamSelectButtonView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import SwiftUI
import ComposableArchitecture

/// チーム選択ボタン
struct TeamSelectButtonView: View {
    /// チーム数
    let teamCount: Int

    var body: some View {
        NavigationLink(destination: TeamsMakeView(store: store(with: teamCount)),
                       label: {
            Text("\(teamCount)チーム")
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 140)
                .padding(.vertical, 12)
                .background(Color.orange)
                .cornerRadius(4)
        })
    }
}

// MARK: Private Methods
private extension TeamSelectButtonView {
    /// Storeを取得
    /// - Parameter teamCount: チーム数
    /// - Returns: StoreOf<TeamsMakeFeature>
    func store(with teamCount: Int) -> StoreOf<TeamsMakeFeature> {
        let initialState = TeamsMakeFeature.State(teamCount: teamCount)
        return Store(initialState: initialState,
                     reducer: TeamsMakeFeature())
    }
}

// MARK: Previews
struct TeamSelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TeamSelectButtonView(teamCount: 1)
            .previewLayout(.sizeThatFits)
    }
}
