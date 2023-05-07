//
//  Player.swift
//  RohitFinalProject2
//
//  Created by Rohit D on 5/3/23.
//

import Foundation



struct Player : Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var team: String
    var position: String
    var heightFeet: Int
    var heightInches: Int
    var weightPounds: Int
}

