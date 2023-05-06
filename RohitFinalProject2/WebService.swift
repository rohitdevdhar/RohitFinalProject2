//
//  WebService.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 5/3/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}
class WebService {
    
    func getPlayers(searchTerm: String) async throws -> [PlayerData] {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "balldontlie.io"
        components.queryItems = [
            URLQueryItem(name: "s", value: searchTerm),
        ]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        let searchResponse = try? JSONDecoder().decode(searchData.self, from:data)
        return searchResponse?.data ?? []
        
    }
    
}
