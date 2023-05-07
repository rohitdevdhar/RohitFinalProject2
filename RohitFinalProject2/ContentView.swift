//
//  ContentView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 4/26/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    
    @State public var players = [ Player(firstName: "First Name", lastName: "Last Name", team: "Team")]
    @State private var defaultString: String = "No player with this name exists"
    @State private var doneString: String = ""
    @State var searchString = ""
        var body: some View {
            
            NavigationView{
                VStack{
                    MainMenuView()
                        .navigationTitle("NBA Player Finder")
                        .offset(y: -60)
                    NavigationLink(destination: PlayerView(), label: {Text("Get Started")})
                    
                }
            }
            
            
        }
}

struct MainMenuView: View {
    var body: some View {
        ZStack{
            Image("NBALogo")
                .resizable()
                .scaledToFit()
                .frame(width:200, height: 200)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct searchData: Decodable {
    let data: [PlayerData]
    let meta: Meta
    //data.reserveCapacity(100)
}
struct PlayerData: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let heightFeet: Int?
    let heightInches: Int?
    let weightPounds: Int?
    let team: Team
}

struct Team: Decodable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String
}


struct Meta: Decodable {
    let totalPages: Int
    let currentPage: Int
    let nextPage: Int?
    let perPage: Int
    let totalCount: Int
}

