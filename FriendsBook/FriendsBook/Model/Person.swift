//
//  Person.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import Foundation

struct Person : Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    var address: Address?
    var company: Company?
}

struct Address : Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

struct Geo : Codable {
    var lat: String?
    var lng: String?
}

struct Company : Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?

}
