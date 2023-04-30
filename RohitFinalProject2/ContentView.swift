//
//  ContentView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 4/26/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @State private var joke: String = ""
    @State var searchString = ""
        var body: some View {
            
            NavigationView{
                VStack{
                    SearchView(searchString: $searchString)
                    MainMenuView()
                        .navigationTitle("NBA Player Finder")
                        .offset(y: -60)
                    NavigationLink(destination: Text("Destination"), label: {Text("Next Screen")})
                }
                
            }
            
            Text(joke)
            Button {
                Task {
                    let (origData, _) = try await URLSession.shared.data(from: URL(string:"https://www.balldontlie.io/api/v1/players?search=Curry")!)
                    /*
                    let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                    joke = decodedResponse?.value2 ?? ""
                     */
                    //let jsonData = data.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let searchData = try decoder.decode(searchData.self, from: origData)
                    joke = searchData.data[1].firstName + "" + String(searchData.meta.totalCount)
                }
            }label: {
                Text("Fetch Joke")
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
    let totalPages: Int?
    let currentPage: Int?
    let nextPage: Int?
    let perPage: Int?
    let totalCount: Int
}
