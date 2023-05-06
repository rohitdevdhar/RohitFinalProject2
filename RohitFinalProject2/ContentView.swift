//
//  ContentView.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 4/26/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    
    
    @State private var defaultString: String = "No player with this name exists"
    @State private var doneString: String = ""
    @State var searchString = ""
        var body: some View {
            NavigationView{
                VStack{
                    MainMenuView()
                        .navigationTitle("NBA Player Finder")
                        .offset(y: -60)
                    NavigationLink(destination: Text("Destination"), label: {Text("Get Started")})
                        .searchable(text: $searchString)
                        .onChange(of: searchString) {value in
                            Task.init {
                                if !value.isEmpty && value.count > 3 {
                                    searchString = value
                                }else{
                                    
                                }
                            }
                        }
                }
                
            }
            Text(doneString)
            Button {
                Task {
                    let perPage = 10
                    let (origData, _) = try await URLSession.shared.data(from: URL(string:"https://www.balldontlie.io/api/v1/players?search=\(searchString)&per_page=\(perPage)")!)
                    /*
                    let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                    joke = decodedResponse?.value2 ?? ""
                     */
                    //let jsonData = data.data(using: .utf8)!
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
                                doneString = searchData1.data[i].firstName + " " + searchData1.data[i].lastName + " " + String(searchData1.meta.totalCount)
                                i = i + 1
                                remainingCount = remainingCount - 1
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

