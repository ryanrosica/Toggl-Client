//
//  TogglControllerLogin.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import KeychainSwift

extension TogglController {
    
    enum LoginResult {
        case success
        case fail
        case networkFail
    }
    
    func checkLogin(completion: @escaping (LoginResult) -> Void) {
        if AuthManager.apiKey == nil {
            completion(.fail)
            return
        }
        
        
        let request = TogglRequest<TogglUserData>(endpoint: TogglEndpoint.user, httpMethod: .GET)
        request.fetch { userResponse in
            switch userResponse {
                case .error(let error):
                    switch error {
                        case .invalid:
                            completion(.fail)
                        case .network:
                            completion(.networkFail)
                    }
                case .success:
                    completion(.success)
            }
    
        }
    }
    
    
    func login (username: String, password: String, completion: @escaping (LoginResult) -> Void) {
        let auth = AuthManager.auth(username: username, password: password)
        let request = TogglRequest<TogglUserData>(endpoint: TogglEndpoint.user, httpMethod: .GET, auth: auth)

        
        request.fetch { userDataResponse in
            
            switch userDataResponse {
                case .error(let error):
                    switch error {
                        case .invalid:
                            completion(.fail)
                        case .network:
                            completion(.networkFail)
                    }
                case .success(let userData):
                    let apiToken = userData.data.api_token
                    AuthManager.store(apiToken: apiToken)
                    completion(.success)
                    self.successHaptic()
                    UserStore.shared.refresh()

                    
            }
        }
    }
    
    
    func logout() {
        AuthManager.delete()
        successHaptic()

    }
}



