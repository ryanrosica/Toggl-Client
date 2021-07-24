//
//  ReportsStore.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine
import Charts
import UIKit
import SwiftUI

class ReportsStore: ViewModel {
    @Published var filter: ReportsFilter
    @Published var summaries: TogglReportSummaryData?
    
    init (filter: ReportsFilter) {
        self.filter = filter
        super.init()
        refresh()
    }
    
    var totalTime: Int {
        return summaries?.total ?? 0
    }
    
    var totalTimeString: String {
        return (totalTime / 1000).stringFromDuration
    }
    
    func percent(from summary: TogglReportSummary) -> Double{
        return (Double(summary.time) / Double(totalTime)).rounded(toPlaces: 4) * 100
    }
    
    var colors: [UIColor] {
        guard let summaries = summaries else { return [] }

        return summaries.summaries.map {
            UIColor($0.color)
        }
    }
    
    var reportCancellable: AnyCancellable?
    func refresh() {
        reportCancellable?.cancel()
        let request = TogglRequest<TogglReportSummaryData>(
            endpoint: ReportsEndpoint.summary(filter),
            httpMethod: .GET,
            base: .reports
        )
        reportCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { summaries in
                if let summaries = summaries {
                    self.summaries = summaries
                }
            })
    }
    
    
    var pieModel: [PieChartDataEntry]  {
        var index = 0
        guard let summaries = summaries else { return [] }

        return summaries.summaries.map {
            index += 1
            return PieChartDataEntry(value: Double($0.time), label: $0.title)
            
        }
    }
}
