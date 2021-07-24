//
//  Date+string.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/1/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

extension Int {
    var stringFromDuration: String {
        let totalSeconds = self
        let hours: Int = totalSeconds / 3600
        let minutes: Int = ( totalSeconds - (3600 * hours) ) / 60
        var result = ""
        if (hours > 0) { result += "\(hours) hours " }
        if (minutes > 0) { result += "\(minutes) minutes " }
        return result
    }
}
