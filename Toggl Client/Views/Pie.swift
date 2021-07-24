//
//  Bar.swift
//  ReportsTest
//
//  Created by Ryan Rosica on 4/15/21.
//

import Foundation
import SwiftUI
import Charts

struct Pie: UIViewRepresentable {

    
    var entries: [PieChartDataEntry]
    var colors: [UIColor]
    
    func makeUIView(context: Context) -> PieChartView {
        let chart = PieChartView()
        chart.data = addData()
        chart.data?.setDrawValues(false)
        chart.legend.enabled = false
        chart.drawEntryLabelsEnabled = false
        chart.holeColor = .secondarySystemGroupedBackground
        return chart
    }
    
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.data = addData()
    }
    func addData() -> PieChartData { 

        let data = PieChartData()
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.label = "Data"
        dataSet.colors = colors
        dataSet.drawValuesEnabled = false

        data.append(dataSet)
        data.setValueFormatter(TimeFormatter())
    
        return data
    }
    
    typealias UIViewType = PieChartView
}

class TimeFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\((value / 3600000).rounded(toPlaces: 1)) hr"

    }
    

}

class HourFormatter: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value / 3600000)) hr"
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
