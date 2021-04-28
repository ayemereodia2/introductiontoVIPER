//
//  Interactor.swift
//  VIPERSample
//
//  Created by Ayemere  Odia  on 28/04/2021.
//

import Foundation
//this is an object
//needs a protocol
//needs a reference to the Presenter
//responsibility of performing interactions.
//when interactions are complete, pass data back to the Presenter
//https://jsonplaceholder.typicode.com/users
enum FetchError:Error {
    case failed
}

protocol AnyInteractor {
    var presenter:AnyPresenter? { get set }
    func getUsers()
}


class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?

    func getUsers() {
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task =  URLSession.shared.dataTask(with: url){[weak self] data,_,error in 
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed) )
                return
            }
            
            do{
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities) )
                return
                
            }catch{
                self?.presenter?.interactorDidFetchUsers(with: .failure(error) )
                return
            }
            
        }
        task.resume()
    }
    
    
    
}
