//
//  AuthManager.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthManager {
    static let keychainKey = "toggl_api_token"
    
    static func store (apiToken: String) {
        let encodedToken = "\(apiToken):api_token".toBase64()
        KeychainSwift().set("Basic \(encodedToken)", forKey: "toggl_api_token")
    }
    
    static var apiKey: String? {
        KeychainSwift().get(keychainKey)
    }
    
    static func auth(username: String, password: String) -> String {
        return "Basic \("\(username):\(password)".toBase64())"
    }
    
    static func delete() {
        let keychain = KeychainSwift()
        keychain.delete(keychainKey)
    }
    
    
}
