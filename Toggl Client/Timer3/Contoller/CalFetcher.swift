//
//  CalFetcher.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/10/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI
import EventKit

struct CalFetcher {
    
    static func fetch(timeInterval: DateRange, completion: @escaping ([TimeBlock]) -> Void) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
                let calendars = eventStore.calendars(for: .event)
                var result = [TimeBlock]()
                for calendar in calendars {

                    let start = timeInterval.start
                    let end = timeInterval.end
                    let predicate = eventStore.predicateForEvents(withStart: start, end: end, calendars: [calendar])
                    let events = eventStore.events(matching: predicate)

                    for event in events {
                        result.append(event)
                    }
                    
                }
                completion( result)

        }
            
    }

    
    
}


extension EKEvent: TimeBlock {
    var name: String {
        return ""
    }
    
    var start: Date? {
        return startDate
    }
    
    var stop: Date? {
        return endDate
    }
    
    var color: Color {
        return Color(.lightGray)
    }
    
}
