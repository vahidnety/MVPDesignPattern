//
//  UserPresenter.swift
//  MVPDesignPattern
//
//  Created by Vahid on 17/07/2021.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    
    func presentUsers(users: [User])
    func presentAlert(title: String, msg: String)
    
}
typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    public func getUsers(){
        guard let url = URL(string: Constants.USER_URL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let decodedJson = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: decodedJson)
                
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }
    
    public func didTap(user: User){
        delegate?.presentAlert(title: user.name, msg: "id: \(user.id) \n Email: \(user.email) \n Username: \(user.username)")
    }
    
}

