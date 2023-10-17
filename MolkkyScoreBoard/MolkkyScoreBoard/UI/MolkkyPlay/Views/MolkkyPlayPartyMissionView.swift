//
//  MolkkyPlayPartyMissionView.swift
//  MolkkyScoreBoard
//
//  Created by ta9yamakawa on 2023/10/18.
//

import SwiftUI

struct MolkkyPlayPartyMissionView: View {
    var body: some View {
        
        VStack {
            Text("Now Loading...")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange.opacity(0.6))
    }
}

#Preview {
    MolkkyPlayPartyMissionView()
}
