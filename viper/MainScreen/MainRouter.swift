//
//  MainRouter.swift
//  viper
//
//  Created by Zapp Antonio on 11/7/21.
//

import Foundation
import UIKit
typealias EntryPoint = View & UIViewController

protocol Router {
    var entryPoint: EntryPoint? {get set}
    static func start() -> Router
}


class MainRouter: Router {
    var entryPoint: EntryPoint?
    
    static func start() -> Router {
        let router = MainRouter()
        
        let presenter = MainPresenter()
        let view = MainViewController()
        let interactor = MainInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entryPoint = view
        
        return router
    }
}
