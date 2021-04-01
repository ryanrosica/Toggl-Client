//
//  RunningTimerStore.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

class RunningTimerStore: ViewModel {
    var isRunning: Bool { runningTimer != nil }
    @Published private(set) var runningTimer: TogglTimer?
    var cancellable: AnyCancellable?

    override init() {
        super.init()
        cancellable = UserStore.shared.$user.sink(receiveValue: { user in
            if (user != nil) {
                self.refresh()
            }
        })
    }
    
    
    var refreshCancellable: AnyCancellable?
    func refresh() {
        let refreshRequest = TogglRequest<TogglTimerData>(
            endpoint: .currentTimeEntry,
            httpMethod: .GET
        )
        refreshCancellable?.cancel()
        state = .loading
        refreshCancellable = refreshRequest.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { self.runningTimer = $0?.data }
        )
    }

    
    var updateCancellable: AnyCancellable?
    func update (timer: TogglTimer) {
        updateCancellable?.cancel()
        guard let runningID = runningTimer?.id else {
            self.state = .error(.invalid)
            return
        }
        self.runningTimer = timer
        let updateRequest = TogglRequest<TogglTimerData>(
            endpoint: .timeEntry(runningID),
            httpMethod: .PUT,
            dataWrapper: TogglTimerData(data: timer)
        )
        state = .loading
        updateCancellable = updateRequest.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { self.runningTimer = $0?.data }
        )
    }
    
    
    var stopCancellable: AnyCancellable?
    func stop() {
        stopCancellable?.cancel()
        guard let id = runningTimer?.id else {
            self.state = .error(.invalid)
            return
        }
        self.state = .loading
        let stopRequest = TogglRequest<TogglTimerData>(
            endpoint: .stopRunning(id),
            httpMethod: .PUT
        )
        stopCancellable = stopRequest.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { data in
                if(data?.data != nil) {
                    self.runningTimer = nil
                }
            }
        )
    }
    
    var startCancellable: AnyCancellable?
    func start (timer: TogglTimer) {
        startCancellable?.cancel()
        state = .loading
        self.runningTimer = timer
        let startRequest = TogglRequest<TogglTimerData>(
            endpoint: .startTimer,
            httpMethod: .POST,
            dataWrapper: TogglTimerData(data: timer)
        )
        startCancellable = startRequest.publisher?.sink(
            receiveCompletion: recieveCompletion,
            receiveValue: { self.runningTimer = $0?.data }
        )
    }
}
