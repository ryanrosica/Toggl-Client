//
//  TogglError.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/1/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

enum TogglError: Error {
    case network
    case invalid
}

enum TogglAPIError: Error {
    case invalid
    case auth
    case network
    case unknown
    
    var localizedDescription: String {
        switch (self) {
            case .network:
                return "There was a network error"
            case .auth:
                return "There was an error with your Toggl Credentials"
            case .invalid:
                return "This operation cannot be completed"
            case .unknown:
                return "This operation cannot be completed"
        }
    }
    
    init (from error: Error) {
        if let urlResponseError = error as? APIClient.URLResponseError {
            if let httpResponse = urlResponseError.response as? HTTPURLResponse {
                self = TogglAPIError(HTTPCode: httpResponse.statusCode) ?? .unknown
            }
        }
        if error is URLError {
            self = .network
        }
        self = .unknown
    }
    
    
    private init? (HTTPCode: Int) {
        if HTTPCode == 404 {
            self = .invalid
        }
        if HTTPCode == 403 {
            self = .auth
        }
        else {
            return nil
        }
            
    }
}
