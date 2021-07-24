//
//  RunningTimerView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/28/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI
import Foundation

struct RunningTimerView: View {
    @State var editing = false
    @EnvironmentObject var store: RunningTimerStore
    @Environment(\.colorScheme) var colorScheme
    @Namespace private var animation


    var body: some View {
            HStack {
                TimeView(timer: store.runningTimer ?? TogglTimer())
                TimerDetailsView(timer: store.runningTimer ?? TogglTimer(), tags: false)

                Spacer()
                stopButton


            }
//            .frame(height: height)
            .sheet(isPresented: $editing) {
                self.timerInspecterView
            }
            .onTapGesture {
                editing = true
            }
        

    }
    
    var timerInspecterView: some View {
        TimerInspectorView (
            timer: .init(
                get: { self.store.runningTimer ?? TogglTimer() },
                set: { self.store.update(timer: $0) }
            )
        )
    }
    
    var stopButton: some View {
        StopButton(
            loading: self.store.state == .loading,
            color: store.runningTimer?.project?.color() ?? UIConstants.Colors.secondaryFont,
            action: {
                withAnimation(.easeInOut) {
                    self.store.stop()
                }

            }
        )
    }
    
    var timeAndStop: some View {
        HStack {
            TimeView(timer: store.runningTimer ?? TogglTimer())
            self.stopButton
        }
    }
    
    let height: CGFloat = 70
    

}
