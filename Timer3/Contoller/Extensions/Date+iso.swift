//
//  Date+iso.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

extension Date {
    var iso: String {
        let iSO8601DateFormatter = ISO8601DateFormatter()
        iSO8601DateFormatter.timeZone = .autoupdatingCurrent
        return iSO8601DateFormatter.string(from: self)
    }
}
