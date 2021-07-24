//
//  Week.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/18/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

struct Week: Hashable, Equatable {
    var startDate: Date
    let calendar = Calendar.autoupdatingCurrent
    func selectedDayInWeek(from date: Date) -> Int? {
        let components = calendar.dateComponents([.year, .month, .weekOfYear], from: date)
        let weekComponents = calendar.dateComponents([.year, .month, .weekOfYear], from: startDate)
        if (
            components.weekOfYear == weekComponents.weekOfYear &&
            components.year == weekComponents.year
        ) {
            return calendar.dateComponents([.day], from: date).day
        }
        return nil
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.startDate == rhs.startDate
    }

    func day(from dayNumber: Int) -> Date {
        var components = calendar.dateComponents([.year, .month, .weekOfYear], from: startDate)
        
        if (calendar.dateComponents([.day], from: startDate).day! > dayNumber) {
            components.month = components.month! + 1
        }
        components.day = dayNumber
        return calendar.date(from: components)!
    }
    
    
    var startDay: Int {
        calendar.dateComponents([Calendar.Component.day], from: startDate).day!
    }
    
    var endDay: Int? {
        let currentMonth = calendar.dateComponents([.month], from: Date()).month!
        let weekMonth = calendar.dateComponents([.month], from: startDate).month!
        if (currentMonth != weekMonth) {
            return nil
        }
        return calendar.dateComponents([.day], from: Date()).day
    }
    
    var wrapDay: Int {

        let range = calendar.range(of: .day, in: .month, for: startDate)!
        let numDays = range.count
        return numDays
    }
    
    init (from date: Date) {
        startDate = date.startOfWeek!
    }
    
    func isFuture(day: Int) -> Bool {
        let components = calendar.dateComponents([.year, .weekOfYear], from: startDate)
        let nowComponents = calendar.dateComponents([.year, .weekOfYear], from: Date())
        
        if (components != nowComponents) { return false }
        let diff = abs(day - today)
        if (diff > 7) { return (day < today) }
        else { return (day > today) }
    }
    
    var today: Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.dateComponents([.day], from: Date()).day!
    }
    
    
    var days: ([(Int, String)]) {
        var result = [(Int, String)]()
        var day = startDay
        for index in 0..<7 {
            result.append((day, daysOfTheWeek[index]))
            day = (day == wrapDay) ? 1 : day + 1
        }
        return result
    }
    
    let daysOfTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
}
