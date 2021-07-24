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
    @State var page: Week = Week(from: Date())
    @Binding var week: Week
    @Binding var selected: Date
    var body: some View {
        VStack(spacing: 0) {
            cal
        }
        .onChange(of: week) { week in
            print("the week \(week)")
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
                    withAnimation {
                        self.selected = Date()

                    }
                }
        }
    }
    
    var cal: some View {
        TabView(selection: $week) {
            ForEach(weekCalendar.weeks.weeks, id: \.self) { week in
                HStack {
                    Spacer()
                    WeekCalendarPageView(week: week, selectedDay: $selected)
                    Spacer()
                }
            }

            
        }
        .onAppear {
            // WORKAROUND: simulate change of selection on appear !!
            let value = page
            page = Week(from: Date.distantPast)
            DispatchQueue.main.async {
                page = value
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .frame(height: 70)
        .animation(.easeInOut)
        
    }
    
    func scrollToSelected() {
        self.page = Week(from: selected)
    }
    
}
