//
//  WeekView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/4/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct WeekCalendarPageView: View {
    var week: Week
    @Binding var selectedDay: Date
    var body: some View {
        HStack(spacing: calSpacing) {
            ForEach(week.days, id: \.0) { (dayNumber, day)  in
                cell(dayNumber: dayNumber, day: day)
            }
        }
    }
    
    func cell(dayNumber: Int, day: String) -> some View {
        VStack (spacing: 0) {
            weekDayLabel (
                selected: (week.selectedDayInWeek(from: selectedDay) == dayNumber),
                day: String(day.first!)
            )
            CalendarCellView (
                selected: (week.selectedDayInWeek(from: selectedDay) == dayNumber),
                number: dayNumber,
                tappable: (!week.isFuture(day: dayNumber)),
                label: day
            )
            .onTapGesture {
                withAnimation {
                    if (!week.isFuture(day: dayNumber)) {
                        selectedDay = week.day(from: dayNumber)
                    }
                }
            }
            .frame(height: heightOfCal)
        }
    }
    
    func weekDayLabel(selected: Bool, day: String) -> some View {
        HStack {
            Spacer()
            Text (day)
                .foregroundColor(selected ? selectedColor : notSelectedColor)
                .font(UIConstants.Fonts.body)
            Spacer()
        }

    }
    
    let heightOfCal: CGFloat = 35
    let calSpacing: CGFloat = 2
    let selectedColor = UIConstants.Colors.theme
    let notSelectedColor = Color.gray
}





