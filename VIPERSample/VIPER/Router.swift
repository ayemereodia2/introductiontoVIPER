//
//  Router.swift
//  VIPERSample
//
//  Created by Ayemere  Odia  on 28/04/2021.
//

import UIKit
//different modules in your app
//routers can route within its own module

//object
//enter point to modules
typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter {
    var entry:EntryPoint? { get set } 
    static func start() -> AnyRouter
}


class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    
    static func start() -> AnyRouter {
        //create all components in viper and return it.
        let router = UserRouter()
        var view:AnyView = UserViewController()
        var interactor:AnyInteractor = UserInteractor()
        var presenter:AnyPresenter = UserPresenter()
        //assign VIP
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
