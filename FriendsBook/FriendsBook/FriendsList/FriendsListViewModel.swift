//
//  FriendListViewModel.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import Foundation

class FriendsListViewModel {
    var state = FriendsListViewState()
    var changeHandler: ((FriendsListViewState.Change) -> Void)?
    var isFilteringHandler: (() -> (Bool))?

    private var isFetching = false
    func numberOfItems() -> Int {
        associatedArray.count
    }
    func itemAtIndex(row: Int) -> Person? {
        associatedArray[row]
    }
    func filterContent(forText text: String) {
        state.filteredItems = state.items.filter({ (content) -> Bool in
            (content.name?.lowercased().contains(text.lowercased()))!
        })
        self.changeHandler?(.friendsSucces)
    }
    func fetchFriends() {
        if isFetching { return }
        isFetching = true
        changeHandler?(.fetchState(fetching: true))
        let service = Service()
        service.getMovies {[weak self] result in
            switch result {
            case .failure(let error):
                self?.changeHandler?(.fetchState(fetching: false))
                self?.changeHandler?(.friendsError(error: error))
                self?.isFetching = false
            case .success(let friends):
                self?.changeHandler?(.fetchState(fetching: false))
                self?.isFetching = false
                self?.state.items = friends
                self?.changeHandler?(.friendsSucces)
            }
        }
    }
}

extension FriendsListViewModel {
  var associatedArray: [Person] {
    isFiltering ? state.filteredItems : state.items
  }
  var isFiltering: Bool {
    isFilteringHandler?() ?? false
  }
}
