//
//  FriendListViewState.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import Foundation
struct FriendsListViewState {
    var items: [Person] = []
    var filteredItems: [Person] = []
}

extension FriendsListViewState {
    enum Change {
        case fetchState(fetching: Bool)
        case friendsSucces
        case friendsError(error: Error?)
    }
}
