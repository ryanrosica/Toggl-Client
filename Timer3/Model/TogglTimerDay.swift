//
//  TogglTimerDay.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

struct TogglTimerDay: Identifiable {
    var id: Date { date }

    var timerGroups: [TogglTimerGroup]
    var date: Date  {
        return timerGroups[0].start!
    }
    var duration: Int {
        timerGroups.map { (group) -> Int in
            let duration = group.duration
            
            if duration < 0 {
                return 0
            }
            else {
                return duration
            }
        }.reduce(0, +)
    }
    
    
}

extension Array where Element == TogglTimer {
    func groupToDays() -> [TogglTimerDay]{
        return self.group(by: \.start?.startOfDay).map {
            TogglTimerDay (
                timerGroups: $0.group(by: \.templateIdentifier)
                    .map { TogglTimerGroup(timers: $0) }
                    .sorted { $0.stop ?? .distantFuture > $1.stop ?? .distantFuture }
            )
        }
    }
}
