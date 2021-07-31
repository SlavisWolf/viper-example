//
//  MainInteractor.swift
//  viper
//
//  Created by Zapp Antonio on 11/7/21.
//

import Foundation

protocol Interactor {
    var presenter: Presenter? {get set}
    
    func getUsers()
}

class MainInteractor: Interactor {
    var presenter: Presenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchErrors.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
                
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        
        task.resume()
    }
    
    
}
