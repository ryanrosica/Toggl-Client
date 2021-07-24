//
//  RecentTimersStoe.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/5/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

class RecentTimersStore: ObservableObject {
    let togglController = TogglController.shared
    @Published var entries: [TogglTimer] = [TogglTimer]()
    @Published var filtered: [TogglTimer] = [TogglTimer]()
    let dateRange = DateRange.month
    let numberOfRecents = 15
    
    var filter: String = "" {
        didSet {
            if (filter == ""){
                filtered = entries
                return
            }
            
            filtered = entries.filter {
                return $0.searchableData.contains(filter)
            }
        }
    }
    
    
    func refresh() {
        togglController.getTimeEntries(from: dateRange.start, to: Date()){[weak self] timers in
            DispatchQueue.main.async {
                if var entries = timers {
                    let reversed: [TogglTimer] = entries.reversed()
                    guard let numberOfRecents = self?.numberOfRecents else { return }
                    entries = Array(reversed[0..<((reversed.count >= numberOfRecents ) ? numberOfRecents : reversed.count)])
                    var newEntries = [TogglTimer]()
                    for timer in entries {
                        var newTimer = timer
                        newTimer.start = nil
                        newTimer.stop = nil
                        if !newEntries.contains(where: {$0.hasTheSameTemplate(as: newTimer)}) {
                            newEntries.append(newTimer)
                        }
                    }
                    
                    self?.entries = newEntries
                    self?.filtered = newEntries
                }
            }
        }
    }
    
    init() {
        refresh()
    }
}
