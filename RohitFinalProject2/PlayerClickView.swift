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
        // this is just where I have created the player card for when a specific player is clicked on
        VStack{
            Text(player.firstName + " " + player.lastName)
                .font(.system(.largeTitle, design: .rounded))
            Circle()
                .fill(Color.cyan)
                .overlay(
                    VStack{
                        
                        Text("Team: " + player.team)
                            .font(.system(size:20, design: .rounded))
                        Text("Position: " + player.position)
                            .font(.system(size:20, design: .rounded))
                        Text("Height Feet: " + (String)(player.heightFeet))
                            .font(.system(size:20, design: .rounded))
                        Text("Height Inches: " + (String)(player.heightInches))
                            .font(.system(size:20, design: .rounded))
                        Text("Weight: " + (String)(player.weightPounds) + " lbs")
                            .font(.system(size:20, design: .rounded))
                    }
                    
                )
        }.background(Color.yellow)
        
        
        
        
    }
}

//struct PlayerClickView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerClickView(player: <#Binding<Player>#>)
//    }
//}
