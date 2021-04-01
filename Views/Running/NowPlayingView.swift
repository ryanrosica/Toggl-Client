//
//  NowPlayingView.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/26/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct NowPlayingView: View {
    @Binding var open: Bool
    @EnvironmentObject var runningStore: RunningTimerStore
    var showing: Binding<Bool> {
        return .init (
            get: {
                switch (runningStore.state) {
                    case .error(_):
                        return true
                    case .loading:
                        return true
                    case .loaded:
                        if (runningStore.isRunning) {
                            return true
                        }
                        return false
                }
            },
            set: { _ in
                runningStore.stop()
            }
        )
    }
    
    var body: some View {
        sheet
            .onReceive(runningStore.$state, perform: { state in
                if (state == .loaded) {
                    open = false
                }
            })
            .onTapGesture {
                self.open = true
            }
    }
    var sheet: some View {
        BottomSheetView(isOpen: $open, showing: showing, maxHeight: maxHeight, minHeight: minHeight, smallContent: {
            RunningTimerView()
                .padding(.horizontal)
        }) {
            if (runningStore.isRunning && runningStore.state != .loading) {
                TimerInspectorViewSmall (
                    timer: .init(get: {self.runningStore.runningTimer ?? TogglTimer()},
                                 set: {self.runningStore.update(timer: $0)}),
                    open: $open, completion: {
                        runningStore.refresh()
                        
                    }
                )
                .padding(.horizontal)
                
            }
        }
    }
    
    
    //MARK: Contants
    let maxHeight: CGFloat = 400
    let minHeight: CGFloat = 85
}

