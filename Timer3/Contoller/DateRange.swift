//
//  DateRange.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/10/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

enum DateRange: CustomStringConvertible {
    var description: String {
        switch(self) {
            case .today:
                return "Today"
            case .month:
                return "This Month"
            case .custom(let start, let end):
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yy"
                return ("\(formatter.string(from: start)) - \(formatter.string(from: end))")
        }
    }
    
    case today
    case month
    case custom (Date, Date)
    
    static var choices = ["Today", "Month", "Custom"]
    
    

    
    var start: Date {
        switch(self) {
            case .today:
                return Date().startOfDay
            case .month:
                return Date().startOfMonth
            case .custom(let start, _):
                return start
        }
    }
    
    var end: Date {
        switch(self) {
            case .today:
                return Date().endOfDay

            case .month:
                return Date().startOfDay
                
            case .custom(_, let end):
                return end
        }
    }
}
