//
//  FriendListViewController.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import UIKit

class FriendsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = FriendsListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupViewModel()
        setupViewModelHandlers()
        setupSearchController()
        configureNavigationBar()
        viewModel.fetchFriends()

        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Friends"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
    }
    
    func showIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.marineBlue
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideIndicator() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}

extension FriendsListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    viewModel.filterContent(forText: searchController.searchBar.text!)
  }
}

extension FriendsListViewController {
    private func setupViewModel() {
        viewModel.changeHandler = { [unowned self] change in
            self.viewModelStateChanged(change: change)
        }
    }
    
    func setupViewModelHandlers() {
        viewModel.isFilteringHandler = {[weak self] in
            guard let self = self else {return false}
            return self.searchController.isActive && !self.isSearchBarEmpty
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search"
        searchController.searchBar.tintColor = UIColor.black
        definesPresentationContext = true
    }
}

extension FriendsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let model = viewModel.itemAtIndex(row: indexPath.row){
            routeToDetail(model: model)
        }
        
    }
}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTableViewCell", for: indexPath) as! FriendListTableViewCell
        cell.configure(with: viewModel.itemAtIndex(row: indexPath.row))
        
        return cell
    }
}

extension FriendsListViewController {
    
    var isSearchBarEmpty: Bool {
     return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func routeToDetail(model: Person) {
        let storyboard = UIStoryboard(name: "FriendDetail", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "FriendDetailViewController") as? FriendDetailViewController {
            destinationVC.model = model
            self.show(destinationVC, sender: nil)
        }
    }

    private func viewModelStateChanged(change: FriendsListViewState.Change){
        switch change {
        case let .fetchState(fetching):
            DispatchQueue.main.async {
                fetching ? self.showIndicator() : self.hideIndicator()
            }
        case .friendsSucces:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .friendsError(let error):
            print(error)
        }
    }
}

