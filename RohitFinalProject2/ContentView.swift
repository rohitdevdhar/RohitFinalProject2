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
        var body: some View {
            Text(joke)
            Button {
                Task {
                    let (data, _) = try await URLSession.shared.data(from: URL(string:"https://www.balldontlie.io/api/v1/players/236")!)
                    /*
                    let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                    joke = decodedResponse?.value2 ?? ""
                     */
                    //let jsonData = data.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let playerData = try decoder.decode(PlayerData.self, from: data)
                    joke = playerData.team.city
                    
                }
            } label: {
                Text("Fetch Joke")
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlayerData: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let heightFeet: Int
    let heightInches: Int
    let weightPounds: Int
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
