//
//  TeamsMakeView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/16.
//

import SwiftUI
import ComposableArchitecture

/// チーム作成画面
struct TeamsMakeView: View {

    /// Store
    let store: StoreOf<TeamsMakeFeature>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: .zero) {
                TeamMembersMakeView(viewStore: viewStore)
                
                Divider().background(Color.black).padding(.bottom)

                Button("決定") {
                    viewStore.send(.didTapDecisionButton)
                }
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(viewStore.state.enableGoNext ? Color.orange : Color.gray)
                .cornerRadius(4)
                .disabled(!viewStore.state.enableGoNext)
            }
            .background(AppColor.base.color)
        }
    }
}

// MARK: Previews
struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())

        TeamsMakeView(store: store)
    }
}
