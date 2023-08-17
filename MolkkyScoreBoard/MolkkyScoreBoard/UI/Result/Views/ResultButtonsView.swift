//
//  ResultButtonsView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/21.
//

import SwiftUI
import ComposableArchitecture

/// 結果画面のボタンに関するView
struct ResultButtonsView: View {

    /// View Store
    let viewStore: ViewStoreOf<ResultFeature>

    /// アラートの表示管理フラグ
    @State private var isPresentedAlert = false

    var body: some View {
        HStack(spacing: 10) {
            Spacer()

            Button("ゲーム終了", action: {
                isPresentedAlert.toggle()
            })
            .alert(isPresented: $isPresentedAlert) {
                gameFinishConfirmAlert(with: viewStore)
            }
            .padding(8)
            .font(Font.system(size: 20))
            .foregroundColor(AppColor.white.color)
            .background(AppColor.main.color)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))

            Button("次のセットへ") {
                viewStore.send(.didTapNextMatchButton)
            }
            .padding(8)
            .font(Font.system(size: 20))
            .foregroundColor(AppColor.white.color)
            .background(AppColor.accent2.color)
            .cornerRadius(4)
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10))

            Spacer()
        }
    }
}

// MARK: Private Methods
private extension ResultButtonsView {
    /// ゲームの終了確認アラートを取得する
    /// - Parameter viewStore: ViewStoreOf<ResultFeature>
    /// - Returns: Alert
    func gameFinishConfirmAlert(with viewStore: ViewStoreOf<ResultFeature>) -> Alert {
        let title = Text("本当に終了しますか？")
        let finishButton: Alert.Button = .default(Text("はい"),
                                                  action: {
            viewStore.send(.didTapFinishButton)
        })
        let cancelButton: Alert.Button = .cancel(Text("いいえ"))

        let alert = Alert(title: title,
                          primaryButton: finishButton,
                          secondaryButton: cancelButton)

        return alert
    }
}

// MARK: Previews
struct ResultButtonsView_Previews: PreviewProvider {
    static var previews: some View {

        let state = ResultFeature.State(teams: TeamsMock().data)
        let viewStore = ViewStore(StoreOf<ResultFeature>(initialState: state,
                                                         reducer: ResultFeature()))
        ResultButtonsView(viewStore: viewStore)
    }
}
