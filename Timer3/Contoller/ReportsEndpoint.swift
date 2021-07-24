//
//  ReportsURL.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

struct Parameter {
    var name: String
    var value: String
    var string: String {
        return "\(name)=\(value)"
    }
}
struct URLParameters {
    var parameters: [Parameter] = []
    let joiningChar = "&"
    let startChar = "?"
    var string: String {
        startChar + parameters.map { $0.string }.joined(separator: joiningChar)
    }
    
    mutating func append(_ parameter: Parameter) {
        parameters.append(parameter)
    }
}

enum ReportsEndpoint: URLEndpoint {
    case weekly(ReportsFilter)
    case detailed(ReportsFilter)
    case summary(ReportsFilter)
    case projectDashboard(ReportsFilter)
    
    func value() -> String {
        switch(self) {
            case .weekly (let filter):
                return "weekly" + value(filter: filter)
            case .detailed(let filter):
                return "detailed" + value(filter: filter)
            case .summary(let filter):
                return "summary" + value(filter: filter)
            case .projectDashboard(let filter):
                return "project" + value(filter: filter)
        }
    }
    func value(filter: ReportsFilter) -> String {
        var parameters = URLParameters()
        let userAgent = "TogglTimer3"


        parameters.append(Parameter(name: "user_agent", value: userAgent))
        parameters.append(Parameter(name: "workspace_id", value: String(filter.workspace_id)))
        
        if let start = filter.since {
            parameters.append(Parameter(name: "since", value: start.iso))
        }
        if let end = filter.until {
            parameters.append(Parameter(name: "until", value: end.iso))
        }
        if let billable = filter.billable {
            parameters.append(Parameter(name: "billable", value: billable ? "yes" : "no"))
        }
        if let projects = filter.projects {
            let pids = projects.map { String($0.id) }.joined(separator: ",")
            parameters.append(Parameter(name: "project_ids", value: pids))
        }
        if let tags = filter.tags {
            let tids = tags.map { String($0.id) }.joined(separator: ",")
            parameters.append(Parameter(name: "tags_ids", value: tids))
        }
        if let entries = filter.timeEntries {
            let ids = entries.map { String($0.id) }.joined(separator: ",")
            parameters.append(Parameter(name: "time_entry_ids", value: ids))
        }
        if let description = filter.description {
            parameters.append(Parameter(name: "description", value: description))
        }
        if let orderField = filter.orderField {
            parameters.append(Parameter(name: "order_field", value: orderField.rawValue))
        }
        
        return parameters.string
    }
}



