//
//  MolkkyPlayPartyMissionView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/10/18.
//

import SwiftUI

/// パーティモードでプレイする際のお題View
struct MolkkyPlayPartyMissionView: View {
    /// お題文
    var mission: String

    var body: some View {
        VStack {
            Text(mission)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange.opacity(0.6))
    }
}
