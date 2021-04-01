//
//  File.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/13/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

struct TogglTag: TogglObject, Identifiable, Equatable {
    var name: String?
    var id: Int
    
    static func == (first: TogglTag, second: TogglTag) -> Bool {
        return
            first.name == second.name
    }
}
