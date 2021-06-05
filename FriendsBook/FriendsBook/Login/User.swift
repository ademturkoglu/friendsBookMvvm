//
//  LoginModel.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 5.06.2021.
//

import Foundation

struct User: Codable{
    var userName: userName?
    var password: password?

}

enum userName: String,Codable {
    case gbf48
    case v542w
    case zdah4
}

enum password: String, Codable {
    case pass123
}
