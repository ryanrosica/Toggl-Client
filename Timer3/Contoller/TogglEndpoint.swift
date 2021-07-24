//
//  TogglEndpoint.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

enum TogglEndpoint: URLEndpoint {
    case currentTimeEntry
    case timeEntry(Int)
    case startTimer
    case stopRunning(Int)
    case project(Int)
    case user
    case timeEntries (String, String)
    case projects
    case bulkTimeEntries ([Int])
    
    func value() -> String {
        switch self {
            case .currentTimeEntry:
                return "time_entries/current"
            case .timeEntry(let id):
                return "time_entries/\(id)"
            case .startTimer:
                return "time_entries/start"
            case .stopRunning (let id):
                return "time_entries/\(id)/stop"
            case .project (let id):
                return "projects/\(id)"
            case .user:
                return "me?with_related_data=true"
            case .timeEntries (let startDate, let endDate):
                return "time_entries?start_date=\(startDate)&end_date=\(endDate)"
            case .bulkTimeEntries(let ids):
                let idsStrings = ids.map{ String($0) }
                return "time_entries/\(idsStrings.joined(separator: ","))"
            case .projects:
                return "projects"
            

        }
    }
}
