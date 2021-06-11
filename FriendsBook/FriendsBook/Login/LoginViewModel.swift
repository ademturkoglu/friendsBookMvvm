//
//  LoginViewModel.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 5.06.2021.
//

import Foundation

class LoginViewModel {
    var state = LoginViewState()
    var changeHandler: ((LoginViewState.Change) -> Void)?
    func login(userName: String?, password: String?) {
        for user in state.items {
            if userName == user.userName?.rawValue ,
               password == user.password?.rawValue {
                self.changeHandler?(.loginSucces)
                break
            } else {
                self.changeHandler?(.loginError(error: LoginErrors.userNotFound))
            }
        }
    }
}

enum LoginErrors: Error {
    case userNotFound
}
