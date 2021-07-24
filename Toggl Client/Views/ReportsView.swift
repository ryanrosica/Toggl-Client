//
//  ContentView.swift
//  Shared
//
//  Created by Ryan Rosica on 4/15/21.
//

import SwiftUI
import Charts

struct ReportsView: View {
    @StateObject var reportsStore = ReportsStore(
        filter: ReportsFilter(
            workspace_id: 4956185,
            since: Date().startOfMonth
        )
    )
    
    @EnvironmentObject var runningStore: RunningTimerStore
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
//                TimePeriodPicker().padding(.horizontal)

                VStack {
                    HStack {
                        SectionHeader(text: reportsStore.totalTimeString)
                        Spacer()
                    }
                    Pie(entries: reportsStore.pieModel, colors: reportsStore.colors)

                }
                .padding()
                .frame(height:400)
                
                HStack {
                    SectionHeader(text: "Breakdown")
                    Spacer()
                }
                .padding()
                ForEach(reportsStore.summaries?.summaries ?? []) { summary in
                    BreakDownView(
                        title: summary.title,
                        color: summary.color,
                        percent: reportsStore.percent(from: summary)
                    )

                    
                }
                

 
            }
            .navigationTitle("This Month")
            .padding(.bottom, runningStore.isRunning ? 90 : 0)
        }




    }
}

struct TimePeriodPicker: View {
    var body: some View {
        VStack {
            Picker(selection: .constant(1), label: Text("Picker"), content: {
                Text("Day").tag(1)
                Text("Week").tag(1)
                Text("Month").tag(2)
                Text("Year").tag(2)
                Text("Custom").tag(2)
            })
            .textCase(nil)
            .pickerStyle(SegmentedPickerStyle())
            Spacer().frame(height: 20)
        }
    }
}

struct BreakDownView: View {
    var title: String
    var color: Color
    var percent: Double
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text(title)
                    .font(.title3)
                    .foregroundColor(color)
                Text("\(percent, specifier: "%.2f")%")

            }
            .padding()
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(.tertiarySystemFill)))
        .padding(.horizontal, 16)
        .padding(.vertical, 2)


        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
            .preferredColorScheme(.light)
            .environmentObject(RunningTimerStore())
    }
}
