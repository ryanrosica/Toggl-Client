//
//  TimerGroup.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/28/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimerGroupView: View {
    var timerGroup: TogglTimerGroup
    @ObservedObject var entriesStore: TimeEntriesStore
    @State var editing = false
    @State var editingTimer = TogglTimer()
    @State var open = false
    var isOpen: Binding<Bool> {
        .init(
            get: {
                open || openAfterDeleted?.timerTemplate.templateIdentifier == timerGroup.timerTemplate.templateIdentifier
            },
            set: {
                open = $0
            }
        )
    }
    @Binding var openAfterDeleted: TogglTimerGroup?
    
    @ViewBuilder
    var body: some View {
        if (timerGroup.timers.count > 1) {
            DisclosureGroup(isExpanded: $open, content: { detailViews }) {
                Button (action: { open.toggle() }) {
                    HStack(spacing: 8) {
                        if (true){
                            Rectangle()
                                .font(.system(size: 46))
                                .foregroundColor(timerGroup.project?.color())
                                .frame(width: 6)
                                .padding(2)
                        }
 
                        TimerDetailsView(timer: timerGroup.timerTemplate).frame(height: rowHeight)
                        Spacer()
                        TimeRange(timer: timerGroup.timerTemplate)
                    }
                }

            }
        }
        else { detailViews }

    }
    
    
    var detailViews: some View {
        ForEach(timerGroup.timers) { timer in
            Button (action: { edit(timer)}) {
                HStack(spacing: 8) {
                    Rectangle()
                        .font(.system(size: 46))
                        .foregroundColor(timerGroup.project?.color())
                        .frame(width: 6)
                        .padding(2)

                    TimerDetailsView(timer: timer)
                    Spacer()
                    TimeRange(timer: timer)
                }
            }
            .frame(height: rowHeight)
            .sheet(isPresented: $editing, content: { editSheet })

        }
        .onDelete {
            openAfterDeleted = timerGroup
            entriesStore.deleteTimer(in: timerGroup, timerIndex: $0.first!)
            
        }

    }
    
    var editSheet: some View {
        TimerInspectorView (
            timer: .init(
                get: {
                    editingTimer
                },
                set: {
                    guard let editingIndex = entriesStore.index(of: editingTimer) else { return }
                    self.entriesStore.update(timer: self.entriesStore.entries[editingIndex], to: $0)
                }
            )
        )
    }
    
    func edit(_ timer: TogglTimer) {
        self.editingTimer = timer
        editing = true

    }
    
    
    //MARK: Constants
    let rowHeight: CGFloat = 55

}
