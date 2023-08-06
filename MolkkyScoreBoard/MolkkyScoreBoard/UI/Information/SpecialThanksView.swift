//
//  SpecialThanksView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/04/13.
//

import SwiftUI

/// スペシャルサンクスView
struct SpecialThanksView: View {
    var body: some View {
        List {
            ForEach(SpecialThanksRole.allCases, id: \.self) { role in
                Section(role.rawValue) {
                    ForEach(role.members, id: \.self) { member in
                        Text(member)
                            .foregroundColor(AppColor.black.color)
                    }
                }
                .listRowBackground(AppColor.bgList.color)
                .foregroundColor(AppColor.font.color)
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppColor.base.color)
    }
}

// MARK: Previews
struct SpecialThanksView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialThanksView()
    }
}
