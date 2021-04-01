//
//  TogglTimerGroup.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

struct TogglTimerGroup: Identifiable {
    var id: [Int] {
        timers.map {
            $0.id
        }
    }
    var timers: [TogglTimer]
    
    var timerTemplate: TogglTimer {
        TogglTimer(
            project: project,
            description: desctiption,
            duration: duration,
            tags: tags,
            start: start,
            stop: stop
        )
    }
    
    var duration: Int {
        timers.map { (timer) -> Int in
            guard let duration = timer.duration else { return 0 }
            
            if duration < 0 {
                return 0
            }
            else {
                return duration
            }
        }.reduce(0, +)
    }
    
    var project: TogglProject? {
        timers[0].project ?? TogglProject()
    }
    var tags: [String] {
        timers[0].tags ?? []
    }
    var desctiption: String? {
        timers[0].description
    }
    
    var stop: Date? {
        timers[0].stop
    }
    
    var start: Date? {
        timers[timers.count - 1].start
    }
    
    mutating func removeTimer(at index: Int) {
        timers.remove(at: index)
    }
}
