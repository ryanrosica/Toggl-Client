//
//  LoginStore.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

class LoginStore: ObservableObject {
    @Published var isLoggedIn: Bool?
    
    init() {
        TogglController.shared.checkLogin {logInResponse in
            DispatchQueue.main.async {
                switch logInResponse {
                    case .fail:
                        self.isLoggedIn = false
                    
                    case .success:
                        self.isLoggedIn = true
                    
                    case .networkFail:
                        self.isLoggedIn = nil
                }
            }
        }
    }
    
    func login(username: String, password: String, completion : @escaping (Bool) -> Void) {
        TogglController.shared.login(username: username, password: password) {result in
            switch(result) {
                case .fail:
                    DispatchQueue.main.async {
                        completion(false)
                        self.isLoggedIn = false
                    }
                case .success:
                    DispatchQueue.main.async {
                        completion(true)
                        self.isLoggedIn = true
                    }
                case .networkFail:
                    DispatchQueue.main.async {
                        completion(true)
                        self.isLoggedIn = nil
                    }
            }
        }
        
    }
    
    func logout() {
        TogglController.shared.logout()
        isLoggedIn = false
    }
}
