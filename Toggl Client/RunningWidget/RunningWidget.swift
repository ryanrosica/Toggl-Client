//
//  RunningWidget.swift
//  RunningWidget
//
//  Created by Ryan Rosica on 10/5/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

#if !targetEnvironment(macCatalyst)

import WidgetKit
import SwiftUI
import Combine

struct Provider: TimelineProvider {
    let widgetStore = WidgetRunningStore()
    
    
    func placeholder(in context: Context) -> RunningEntry {
        RunningEntry(date: Date(), timer: TogglTimer(project: TogglProject(name: "PLACEHOLDER")))
    }

    func getSnapshot(in context: Context, completion: @escaping (RunningEntry) -> ()) {
        widgetStore.refresh {
            let entry = RunningEntry(date: Date(), timer: $0)
            completion(entry)
        }
        

    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {


        
        widgetStore.refresh { timer in
            var entries: [RunningEntry] = []
            let currentDate = Date()
            for secondOffset in 0 ..< 10000 {
                let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
                let entry = RunningEntry(date: entryDate, timer: timer)
                entries.append(entry)
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }

//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = RunningEntry(date: entryDate, timer: TogglTimer())
//
//            entries.append(entry)
//        }

    }
}

struct RunningEntry: TimelineEntry {
    let date: Date
    let timer: TogglTimer?
}

struct RunningWidgetEntryView : View {
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        if entry.timer != nil {
            Text(entry.timer!.currentTime(from: entry.date))
                .font(.system(size: 40, weight: .black, design: .default))
                .foregroundColor(entry.timer?.project?.color() ?? .gray)
            TimerDetailsView(timer: entry.timer!)
        }
        else {
            Text("Fuck")
        }
    }
}

@main
struct RunningWidget: Widget {
    let kind: String = "RunningWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in

                RunningWidgetEntryView(entry: entry)
            

        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct RunningWidget_Previews: PreviewProvider {
    static var previews: some View {
        RunningWidgetEntryView(entry: RunningEntry(date: Date(), timer: TogglTimer(project: TogglProject(name: "PLACEHOLDER"))))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

class WidgetRunningStore {
    
    let request = TogglRequest<TogglTimerData>(endpoint: .currentTimeEntry, httpMethod: .GET)
    
    var completion: ((TogglTimer?) -> Void)?
    
    
    var cancellable: AnyCancellable?
    func refresh(completion: @escaping (TogglTimer?) -> Void) {

        
        print("REFRESHHH")
        
        self.completion = completion
        
        cancellable?.cancel()
        
        UserStore.shared.refresh() {
            self.cancellable = self.request.publisher?
                .replaceError(with: TogglTimerData(data: TogglTimer(project: TogglProject(name: "Nothing recieved"))))
                .sink(receiveValue: {
                    if let timer = $0?.data {
                        completion(timer)
                    }

                })
        }
        

    }
}
#endif
