//
//  Weeks.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/18/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

struct Weeks {
    var weeks: [Week]
    
    init() {
        var date = Date()
        weeks = [Week]()
        for _ in 0..<100 {
            weeks.insert(Week(from: date), at: 0)
            let dayComp = DateComponents(day: -7)
            date = Calendar.current.date(byAdding: dayComp, to: date)!
        }
    }
    
    
    func pageOf(date: Date) -> Int? {
        let calendar = Calendar.autoupdatingCurrent
        let dateComponents = calendar.dateComponents([.year, .weekOfYear], from: date)
        let index = weeks.firstIndex(where: {
            let components = calendar.dateComponents([.year, .weekOfYear], from: $0.startDate)
            return (
                calendar.date(from: components) == calendar.date(from: dateComponents) &&
                components.weekOfYear == dateComponents.weekOfYear
            )
        })
        return index
    }
}

