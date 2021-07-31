//
//  MainPresenter.swift
//  viper
//
//  Created by Zapp Antonio on 11/7/21.
//

import Foundation

enum FetchErrors: Error {
    case failed
}

protocol Presenter {
    var router: Router? {get set}
    var view: View? {get set}
    var interactor: Interactor? {get set}
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}


class MainPresenter: Presenter {
    var router: Router?
    
    var view: View?
    
    var interactor: Interactor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
            case .success(let users):
                view?.update(with: users)
            case .failure(_):
                view?.update(with: "Something went worng")
        }
    }
    
    
}
