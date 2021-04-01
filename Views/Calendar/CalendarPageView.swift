//
//  WeekCalendarView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/9/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct CalendarPageView: View {
    @StateObject var weekCalendar = WeekCalendar()
    @State var page: Int = 99
    @Binding var selected: Date
    var body: some View {
        VStack(spacing: 0) {
            cal
        }
        .onChange(of: selected) { _ in
            scrollToSelected()
        }
    }
    
    var labels: some View {
        HStack {
            DatePicker("", selection: $selected, in: PartialRangeThrough(Date()), displayedComponents: [.date])
                .animation(.none)
                .frame(maxWidth: 80)
            Spacer()
            
            Text("Today")
                .font(UIConstants.Fonts.body)
                .foregroundColor(UIConstants.Colors.theme)
                .onTapGesture {
                    self.selected = Date()
                    self.page = 99
                }
        }
    }
    
    var cal: some View {
        ModelPages(
            weekCalendar.weeks.weeks,
            currentPage: $page,
            navigationOrientation: .horizontal,
            transitionStyle: .scroll,
            bounce: true,
            wrap: false,
            hasControl: false,
            control: nil
        ) { _, week  in
            HStack {
                Spacer()
                WeekCalendarPageView(week: week, selectedDay: $selected)
                Spacer()
            }
            
        }
        .frame(height: 70)
        .animation(.none)
        
    }
    
    func scrollToSelected() {
        self.page = weekCalendar.weeks.pageOf(date: selected) ?? 99
    }
    
}
