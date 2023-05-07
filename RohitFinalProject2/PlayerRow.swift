//
//  PlayerRow.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 5/6/23.
//

import SwiftUI

var playerRow: Player {
    var body: some View {
        HStack {
                    
            Text(verbatim: playerRow.firstName)
                    Spacer()
                }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        playerRow()
    }
}
