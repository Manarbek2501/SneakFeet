//
//  User.swift
//  SneakFeet
//
//  Created by Manarbek Bibit on 27.05.2023.
//

import Foundation

struct User:Identifiable, Codable {
    let id: String
    var username: String
    var password: String
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, username: "manarbek", password: "1234567mb")
}
