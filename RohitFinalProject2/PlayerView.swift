//
//  PlayerView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 5/6/23.
//

import SwiftUI

struct PlayerView: View {
    
    @State public var players = [Player(firstName: "First Name", lastName: "Last Name", team: "Team", position: "Position", heightFeet: -1, heightInches: -1, weightPounds: -1)]
    @State private var selectedPlayer: Player = Player.init(firstName: "First Name", lastName: "Last Name", team: "Team",position: "Position", heightFeet: -1, heightInches: -2, weightPounds: -1)
    
    
    @State private var defaultString: String = "No results found"
    @State private var doneString: String = ""
    @State var searchString = ""
    var body: some View {
        
        
        NavigationView{
            VStack{
                MainMenuView2()
                    .offset(y:-150)
                    .searchable(text: $searchString)
                    .onChange(of: searchString) {value in
                        Task.init {
                            if !value.isEmpty && value.count > 0 {
                            searchString = value
                            players = [ Player(firstName: "First Name", lastName: "Last Name", team: "Team",position: "Position", heightFeet: -1, heightInches: -1, weightPounds: -1)]
                            }else{
                                                
                            }
                        }
                    }
                ScrollView{
                    List(players){player in
                        NavigationLink(destination: PlayerClickView(player: $selectedPlayer).onAppear(){
                            selectedPlayer.firstName = player.firstName
                            selectedPlayer.lastName = player.lastName
                            selectedPlayer.team = player.team
                            selectedPlayer.position = player.position
                            selectedPlayer.heightFeet = player.heightFeet
                            selectedPlayer.heightInches =
                                player.heightInches
                            selectedPlayer.weightPounds = player.weightPounds
                        }){
                            HStack{
                                Text(player.firstName)
                                Text(player.lastName)
                                Text(player.team)
                            }
                        }
                    }.scaledToFill()
                    
                    
                }
                Text(doneString)
                Button {
                    Task {
                        let perPage = 100
                        let (origData, _) = try await URLSession.shared.data(from: URL(string:"https://www.balldontlie.io/api/v1/players?search=\(searchString)&per_page=\(perPage)")!)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        var searchData1 = try decoder.decode(searchData.self, from: origData)
                       
                        var remainingCount = 0
                        if(searchData1.meta.totalCount == 0){
                            doneString = defaultString
                        }else{
                            remainingCount = searchData1.meta.totalCount
                            var currentPageTotal = 0
                            while(remainingCount > 0){
                                if(searchData1.meta.currentPage < searchData1.meta.totalPages){
                                    currentPageTotal = perPage
                                }else{
                                    currentPageTotal = searchData1.meta.totalCount - ((searchData1.meta.totalPages - 1) * perPage)
                                }
                                var i = 0
                                while(i < currentPageTotal){
                                    doneString =  String(searchData1.meta.totalCount) + " results found"
                                    remainingCount = remainingCount - 1
                                    players.append(Player(firstName: searchData1.data[i].firstName, lastName: searchData1.data[i].lastName, team: searchData1.data[i].team.fullName, position: searchData1.data[i].position, heightFeet: searchData1.data[i].heightFeet ?? -1, heightInches: searchData1.data[i].heightInches ?? -1, weightPounds: searchData1.data[i].weightPounds ?? -1 ))
                                     
                                    i = i + 1
                                }
                                let (origData, _) = try await URLSession.shared.data(from: URL(string:"https://www.balldontlie.io/api/v1/players?search=\(searchString)&page=\(String(describing: searchData1.meta.nextPage) )")!)
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                searchData1 = try decoder.decode(searchData.self, from: origData)
                                
                            }
                            
                        }
                        

                    }
                    
                }label: {
                    Text("Get your Player Data")
                }
                
                
                
            }
            
        }
        
        
        
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

struct MainMenuView2: View {
    var body: some View {
        ZStack{
            
        }
        Image("NBALogo")
            .resizable()
            .scaledToFit()
            .frame(width:25, height: 25)
    }
    
}
