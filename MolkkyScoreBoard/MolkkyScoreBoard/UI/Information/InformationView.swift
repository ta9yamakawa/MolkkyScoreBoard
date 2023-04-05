//
//  InformationView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/02/12.
//

import SwiftUI

/// インフォメーション画面
struct InformationView: View {

    var body: some View {
        List {
            NavigationLink("Information", destination: {
                Text("hoge")
            })

            Text("バージョン：\(AppVersion.currentVersion)")
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
