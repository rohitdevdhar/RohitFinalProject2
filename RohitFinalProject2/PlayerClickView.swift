//
//  PlayerClickView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 5/7/23.
//

import SwiftUI

struct PlayerClickView: View {
    @Binding var player: Player
    var body: some View {
        
        Text("First Name: " + player.firstName)
        Text("Last Name: " + player.lastName)
        Text("Team: " + player.team)
        Text("Position: " + player.position)
        Text("Height Feet: " + (String)(player.heightFeet))
        Text("Height Inches: " + (String)(player.heightInches))
        Text("Weight Pounds: " + (String)(player.weightPounds))
    }
}

//struct PlayerClickView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerClickView(player: <#Binding<Player>#>)
//    }
//}
