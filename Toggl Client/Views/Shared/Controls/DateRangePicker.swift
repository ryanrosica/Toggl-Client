//
//  DateRangePicker.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/11/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct DateRangePicker: View {
    var dateWidth: CGFloat
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    var displayedComponents: DatePicker.Components = [.date]


    @ViewBuilder
    var body: some View {

        if (startDate != nil) {
            timeCell(Binding($startDate)!, label: startLabel, image: iconName, color: startColor, rangeEnd: endDate)
        }

        if (endDate != nil) {

            timeCell(Binding($endDate)!, label: endLabel, image: iconName, color: endColor, rangeStart: startDate)

        }
    }



    func timeCell (_ date: Binding<Date> ,label: String, image: String, color: Color, rangeStart: Date? = nil,  rangeEnd: Date? = nil) -> some View {
        FormCell(

            label: label,
            content:
                DatePicker (
                    "",
                    selection: date,
                    in: (rangeStart ?? Date.distantPast)...(rangeEnd ?? (.distantFuture)),
                    displayedComponents: displayedComponents
                )
                .accentColor(UIConstants.Colors.theme)
                .frame(width: dateWidth),
            image: image,
            tint: color
        )
    }


    //MARK: Constants
    let startLabel = "Start"
    let startColor = Color.green
    let endColor = Color.red
    let endLabel = "End"
    let iconName = "timer"
}
