//
//  CalendarEntriesViewModel.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 2/8/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

extension TimeEntriesStore {
    
    
    
    func startAndEndPercentages(timer: TimeBlock) -> (Double, Double)? {
        let secondsPerDay: Double = 86400
        let calendar = Calendar.autoupdatingCurrent
        var startSecond: Double
        var stopSecond: Double

        guard let startDate = timer.start else { return nil}
        guard let endDate = timer.stop else { return nil}

        startSecond = (Double)(calendar.dateComponents([.second], from: startDate).second!) +
                        (Double)(calendar.dateComponents([.minute], from: startDate).minute!) * 60 +
                        (Double)(calendar.dateComponents([.hour], from: startDate).hour!) * 60 * 60
 
        stopSecond = (Double)(calendar.dateComponents([.second], from: endDate).second!) +
                (Double)(calendar.dateComponents([.minute], from: endDate).minute!) * 60 +
            (   Double)(calendar.dateComponents([.hour], from: endDate).hour!) * 60 * 60
        
        let startP: Double  = startSecond / secondsPerDay
        let stopP: Double = stopSecond / secondsPerDay
        
        return (startP, stopP)
        
    }
    
    
}
