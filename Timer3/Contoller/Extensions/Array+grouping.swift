//
//  Array+Grouping.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

extension Array {
    func group<T: Hashable>(by groupingData: (Element) -> T) -> [[Element]] {
        let grouped = Dictionary(grouping: self, by: groupingData)
        return grouped.map { $0.value }
    }
}
