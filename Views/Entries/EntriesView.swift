//
//  SwiftUIView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/22/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct EntriesView: View {
    @ObservedObject var entriesStore: TimeEntriesStore
    @Environment(\.colorScheme) var colorScheme
    @State var animated = false
    @Namespace private var animation
    @State var calendar = false
    @State var openAfterDeleted: TogglTimerGroup?
    @ObservedObject var searchBar: SearchBar = SearchBar()
    var views = ["Timeline", "List"]

    var isAnimated: Bool {
        return animated && entriesStore.state != .loading
    }
    
    var viewPicker: some View {
    
        Picker (
            selection: .init(
                get: { (calendar) ? "Timeline" : "List" },
                set: {
                    if ($0 == "Timeline") {
                        calendar = true
                    }
                    else {
                        calendar = false
                    }
                }
            ),
            label: (
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
            )
        ) {
            ForEach(views, id: \.self) {
                Text($0)
                    .textCase(nil)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }

//    var body: some View {
//        VStack (spacing: 0){
//
//            entriesList
//        }
//        .background(Color(.systemGroupedBackground))
//    }
    var body: some View {
        ScrollViewReader { value in
//            VStack {
//                Button("Scroll") {
//                }
//            }

            list

        }
    }
    
    @ViewBuilder
    var list: some View {
        List {
            Section (header:
                VStack(spacing: 0) {
                    Divider()
                        .animation(.none)

                    CalendarPageView(selected: bindingDate)
                        .font(UIConstants.Fonts.body)
                        .animation(.none)

                    Divider()
                        .animation(.none)
                    
                    SegmentedBarView(model: entriesStore.barModel)
                        .frame(height: 5)
                        .padding()
                        .animation(.none)

                    
                    Divider()
                        .animation(.none)


                }
                .listRowInsets(EdgeInsets())
                        .background(Color(.systemBackground))

                .animation(.none)


            
            ){

                if (entriesStore.entries.count > 0 && entriesStore.state == .loaded) {
//                    ZStack {




//                            .shadow(color: Color(.gray).opacity(0.3), radius: 10, x: 0, y: 0)
//                        HStack {
//                            Text(entriesStore.duration).font(UIConstants.Fonts.sectionHeader.bold())
//                                .foregroundColor(.white)
//                        }

//                    }

                    if (!calendar) {
                        ForEach (entriesStore.days) { day in
                            ForEach (day.timerGroups) {
                                TimerGroupView (
                                    timerGroup: $0,
                                    entriesStore: self.entriesStore,
                                    openAfterDeleted: $openAfterDeleted
                                )

                            }
                            .onDelete {
                                entriesStore.deleteTimers(in: day, index: $0.first!)

                            }
                        }
                    }
                    else {
                        CalendarEntriesView(entriesStore: entriesStore)
                            .frame(height: 2000)

                        

                    }



                }
                if entriesStore.entries.count == 0 && entriesStore.state == .loaded{
                    Section {
                        noEntriesFound

                    }
                }
                
                
            }

        }
        .add(self.searchBar)

        .animation(isAnimated ? .easeInOut : .none)
        .listStyle(PlainListStyle())
        .navigationBarTitle("Entry Log", displayMode: .large)
        .onAppear {
            UITableView.appearance().showsVerticalScrollIndicator = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.animated = true
            }
        }
        .navigationBarItems(leading: viewPicker, trailing: calendarController)
    }
    

    
    var barButtons: some View {
        HStack {
            calendarController
            calButton
            
        }
    }
    var calButton: some View {
        Button(action: {calendar = true}) {
            Image(systemName: "calendar")
                .foregroundColor(UIConstants.Colors.theme)
        }
    }
    
    var calendarController: some View {
        HStack {
            DatePicker (
                "",
                selection: bindingDate,
                in: PartialRangeThrough(Date()),
                displayedComponents: [.date]
            )
            .animation(.none)
            .padding(.horizontal)
            .frame(width: datePickerWidth)
        }

    }

    var noEntriesFound: some View {
        VStack {
            Spacer().frame(height: 30)
            HStack {
                Spacer()

                VStack {
                    Image(systemName: "folder.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 60))
                    Text("No Entries found")
                        .foregroundColor(.gray)
                        .bold()
                    
                }
                Spacer()

            }
            
            Spacer().frame(height: 30)


        }
    }
    
    
    
    var bindingDate: Binding<Date> {
        return .init (
            get: { return entriesStore.dateRange.start},
            set: { entriesStore.dateRange = .custom($0.startOfDay, $0) }
        )
    }

    
    //MARK: Constants
    
    let datePickerWidth: CGFloat = 120
    let rowBackground = Color(.clear)
    let marginPadding: CGFloat = -20
    let verticalMarginPadding: CGFloat = -7
    let title = "Entries"

}




