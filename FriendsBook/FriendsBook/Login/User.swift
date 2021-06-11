//
//  LoginModel.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 5.06.2021.
//

import Foundation

struct User: Codable {
    var userName: UserName?
    var password: Password?
}

enum UserName: String,Codable {
    case gbf48
    case v542w
    case zdah4
}

enum Password: String, Codable {
    case pass123
}
