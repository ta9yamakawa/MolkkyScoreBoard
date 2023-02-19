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

    //    @State var team: TeamDto = ""

    @State private var inputText = ""

    /// チーム数
    let teamCount: Int

    /// Team Make Feature
    let store: StoreOf<TeamsMakeFeature>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                List {
                    VStack {
                        ForEach(viewStore.state.teams) { team in
                            HStack {
                                Text("Team\(team.id + 1)")
                                Spacer()
                            }.padding(.leading)

                            TextField("チーム名を入力",
                                      text: $inputText)
                            .onSubmit {
    //                                viewStore.binding(send: .didChangedTextFiled(teamId: team, text: inputText))
                                print(viewStore.displayName)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                            Button(action: {
                                print("追加")
                            }, label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            })
                        }
                    }
                }.padding(.top)

                Divider().background(Color.black)

                Button(action: {
                    print("決定")
                }, label: {
                    Text("決定")
                }).padding(.vertical, 5)
            }
        }
    }
}

// MARK: Previews
struct TeamMakeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: TeamsMakeFeature.State(teamCount: 2),
                          reducer: TeamsMakeFeature())

        TeamsMakeView(teamCount: 2, store: store)
    }
}
