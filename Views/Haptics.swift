//  Haptics.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 12/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import UIKit

struct Haptics {
    static var last: Date?
    static func success() {
        guard (Date().timeIntervalSince(last ?? Date()) > 1 || last == nil) else { return }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        last = Date()
    }
}
