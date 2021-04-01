//
//  HTTPMethod.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/1/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE

    func value() -> String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        }
    }
}
