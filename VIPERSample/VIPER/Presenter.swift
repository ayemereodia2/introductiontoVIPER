//
//  Presenter.swift
//  VIPERSample
//
//  Created by Ayemere  Odia  on 28/04/2021.
//

import UIKit
//this is the glue that ties EVERYTHING TOGETHER
//object
//protocol
//has ref to 3 PARTS
//has reference to Interactor,Router and the View

protocol AnyPresenter {
    var router:AnyRouter? { get set }
    var interactor:AnyInteractor? { get set }
    var view:AnyView? { get set }
    func interactorDidFetchUsers(with results:Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUsers(with results: Result<[User], Error>) {
        switch results {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong!")
        }
    }
    
    
}
