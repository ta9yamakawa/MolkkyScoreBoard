//
//  MolkkyPlayView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/03/02.
//

import SwiftUI
import ComposableArchitecture

/// モルックプレイ画面
struct MolkkyPlayView: View {

    /// Store
    @State var store: StoreOf<MolkkyPlayFeature>? = nil
    
    /// ゲームが開始されているか
    @State private var isDoneStart = false

    var body: some View {
        if let store = store {
            WithViewStore(store) { viewStore in
                ZStack {
                    // プレイ画面
                    PlayView(viewStore: viewStore)
                        .background(AppColor.base.color)
                        .navigationBarBackButtonHidden(true)

                    // ミッションのお題画面（フェードで出し分け）
                    MolkkyPlayPartyMissionView(mission: viewStore.mission.rawValue)
                        .ignoresSafeArea()
                        .opacity(viewStore.animationViewOpacity)
                        .animation(.linear(duration: 0.3), value: viewStore.animationViewOpacity)
                        .onChange(of: viewStore.animationViewOpacity) { _ in
                            guard viewStore.animationViewOpacity != .zero else {
                                return
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                viewStore.send(.fadeOutMission)
                            }
                        }

                }
                .onAppear(perform: {
                    if !isDoneStart {
                        viewStore.send(.start)
                        isDoneStart = true
                    }
                })
            }
        }
    }
}

// MARK: プレイ画面
private struct PlayView: View {

    typealias PlayViewStore = ViewStore<MolkkyPlayFeature.State,
                                        MolkkyPlayFeature.Action>

    /// View Store
    let viewStore: PlayViewStore

    /// アラートの表示管理フラグ
    @State private var isPresentedAlert = false

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    isPresentedAlert.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(AppColor.font.color)
                })
                .alert(isPresented: $isPresentedAlert) {
                    gameFinishConfirmAlert(with: viewStore)
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            // パーティモードのお題
            if UserDefaultsBool.shared.get(forKey: .isPartyMode) {
                Text(viewStore.mission.rawValue)
            }

            SkittlesView(viewStore: viewStore)
                .padding(.bottom, 10)

            ScrollViewReader { reader in
                PlayingButtonsView(viewStore: viewStore, reader: reader)

                TeamScoresView(viewStore: viewStore)
            }
        }
    }

    /// ゲームの終了確認アラートを取得する
    /// - Parameter viewStore: PlayViewStore
    /// - Returns: Alert
    private func gameFinishConfirmAlert(with viewStore: PlayViewStore) -> Alert {
        let title = Text("ゲームを中断しますか？")
        let finishButton: Alert.Button = .default(Text("中断する"),
                                                  action: {
            viewStore.send(.didTapCloseButton)
        })
        let cancelButton: Alert.Button = .cancel(Text("キャンセル"))

        let alert = Alert(title: title,
                          primaryButton: finishButton,
                          secondaryButton: cancelButton)

        return alert
    }
}

// MARK: Previews
struct MolkkyPlayView_Previews: PreviewProvider {
    static var previews: some View {
        let state = MolkkyPlayFeature.State(teams: TeamsMock().data)
        MolkkyPlayView(store: Store(initialState: state,
                                    reducer: MolkkyPlayFeature()))
    }
}
