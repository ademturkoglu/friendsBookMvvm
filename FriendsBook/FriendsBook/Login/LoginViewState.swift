//
//  LoginViewState.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 5.06.2021.
//

import Foundation

struct LoginViewState {
    var items = [User(userName: .gbf48, password: .pass123),
            User(userName: .v542w, password: .pass123),
           User(userName: .zdah4, password: .pass123)]
        
    
    
}

extension LoginViewState {
    enum Change {
        case fetchState(fetching: Bool)
        case loginSucces
        case loginError(error: Error?)
    }
}
