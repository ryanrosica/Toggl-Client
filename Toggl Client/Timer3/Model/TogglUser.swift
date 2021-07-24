//
//  TogglUserData.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/5/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

public struct TogglUser: TogglObject {
    var id = UUID().hashValue
    var email: String?
    var projects: [TogglProject]?
    var workspaces: [TogglWorkspace]?
    var tags: [TogglTag]?
    var api_token: String
    var fullname: String
    
    func project(with name: String) -> TogglProject? {
        return projects?.first(where: { name == $0.name })
    }
    
    
}


