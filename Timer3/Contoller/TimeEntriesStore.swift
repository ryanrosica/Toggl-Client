//
//  TimeEntriesStore.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/22/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

class TimeEntriesStore: ViewModel {
    let togglController = TogglController.shared
    @Published var days = [TogglTimerDay]()
    @Published var calEvents: [TimeBlock] = []
    @Published var dateRange: DateRange {
        didSet { self.refresh() }
    }
    private(set) var entries: [TogglTimer] = [TogglTimer]() {
        didSet { group() }
    }
    @Published var loading = false
    
    var duration: String {
        let totalSeconds = TogglTimerGroup(timers: entries).duration
        let hours: Int = totalSeconds / 3600
        let minutes: Int = ( totalSeconds - (3600 * hours) ) / 60
        var result = ""
        if (hours > 0) { result += "\(hours) hours " }
        if (minutes > 0) { result += "\(minutes) minutes " }
        return result
    }
    
    var cancellable: AnyCancellable?

    var barModel: SegmentedBarViewModel {
        let groups = entries.group(by: \.project).map { entryGroup in
            TogglTimerGroup(timers: entryGroup)
        }
        let segments = groups.map {
            Segment (
                title: $0.project?.name ?? "No Project",
                color: $0.project?.color() ?? .gray,
                weight: $0.duration
            )
        }
        return SegmentedBarViewModel(segments: segments.sorted(by: { $0.title > $1.title }))
    }
    
    
    override init() {
        self.dateRange = .today
        super.init()
        cancellable = UserStore.shared.$user.sink(receiveValue: { _ in self.refresh()})
        refresh()
    }
    
    private func group() {
        self.days = entries.group(by: \.start?.startOfDay).map {
            TogglTimerDay (
                timerGroups: $0.group(by: \.templateIdentifier)
                    .map { TogglTimerGroup(timers: $0) }
                    .sorted { $0.stop ?? .distantFuture > $1.stop ?? .distantFuture }
            )
        }
        objectWillChange.send()
    }
    
    func index(of timer: TogglTimer) -> Int? {
        return entries.firstIndex(where: {[timer] in $0.id == timer.id})
    }
    
    var refreshCancellable: AnyCancellable?
    func refresh() {
        CalFetcher.fetch(timeInterval: dateRange) { events in
            DispatchQueue.main.async { 
                self.calEvents = events
            }
        }
        let adjustedEnd = Calendar.current.date(byAdding: .day, value: 1, to: dateRange.end)!
        DispatchQueue.main.async {
            self.state = .loading
        }
        refreshCancellable?.cancel()
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        let request = TogglRequest<[TogglTimer]>(
            endpoint: .timeEntries(
                formatter.string(from: self.dateRange.start),
                formatter.string(from: adjustedEnd)
            ),
            httpMethod: .GET
        )
        refreshCancellable = request.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { entries in
                guard let entries = entries else {
                    self.state = .error(.unknown)
                    return
                }
                self.entries = entries.reversed()
            })
    }
    
    var deleteCancellable: AnyCancellable?
    func delete(timer: TogglTimer) {
        self.state = .loading
        self.entries.removeAll(where: {timer.id == $0.id})
        let request = TogglRequest<TogglTimerData>(endpoint: .timeEntry(timer.id), httpMethod: .DELETE)
        deleteCancellable = request.publisher?.sink (
            receiveCompletion: recieveCompletion,
            receiveValue: { timer in
                self.state = .loaded
            }
        )
        self.state = .loaded
    }
    
    
    func deleteTimer(in group: TogglTimerGroup, timerIndex: Int) {
        let timer = group.timers[timerIndex]
        delete(timer: timer)
    }

    func update(timer oldTimer: TogglTimer, to newTimer: TogglTimer) {
        togglController.update(timer: oldTimer, to: newTimer) {
            self.refresh()
        }
    }
    
    
    
    

    
}
