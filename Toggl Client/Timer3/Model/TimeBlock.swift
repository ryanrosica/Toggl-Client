//
//  TimeBlock.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/10/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import SwiftUI
import Foundation


protocol TimeBlock {
    var color: Color { get }
    var name: String { get }
    var start: Date? { get }
    var stop: Date? { get }
  
}

extension TimeBlock {
    var id: String {
        return name + String(start?.timeIntervalSinceNow ?? 0)
    }
}
