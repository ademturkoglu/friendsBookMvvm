//
//  Service.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import Foundation

enum FriendsErrors: Error {
    case noDataAvailable
    case notProcessData
}

struct Service {
    let resourceURL: URL
    
    init() {
        let resourceString = "https://jsonplaceholder.typicode.com/users"
        
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    
    func getMovies(completion: @escaping(Result<[Person], FriendsErrors>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let friendsResponse = try decoder.decode([Person].self, from: jsonData)
                completion(.success(friendsResponse))
            } catch {
                completion(.failure(.notProcessData))
            }
            
        }
        dataTask.resume()
    }
}
