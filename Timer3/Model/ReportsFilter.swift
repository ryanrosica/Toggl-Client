//
//  ReportsFilter.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

struct ReportsFilter {
    var workspace_id: Int
    var since: Date?
    var until: Date?
    var billable: Bool?
    var projects: [TogglProject]?
    var tags: [TogglTag]?
    var timeEntries: [TogglTimer]?
    var description: String?
    var orderField: OrderField?

    enum OrderField: String {
        case date = "data"
        case description = "description"
        case duration = "duration"
        case user = "user"
        case title = "title"
        case amount = "amount"
    }
    
}
