//
//  ContentView.swift
//  Timer2
//
//  Created by Ryan Rosica on 4/26/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var runningStore: RunningTimerStore
    @ObservedObject var savedTimers: SavedTimersStore
    @ObservedObject var recentStore: RecentTimersStore
    @State var editing = false
    @State var editingIndex = 0
    @State var isEditable = false
    @Environment(\.colorScheme) var colorScheme
    @StateObject var searchBar: SearchBar = SearchBar()

    
    var body: some View {
        list
            .padding(.bottom, runningStore.isRunning ? 80 : 0)
    }
    
    var list: some View {
        List {
            recentsHorizontalList.textCase(nil)
            pinnedTimerList
        }
        .animation(.easeInOut)
        .listStyle(PlainListStyle())
        .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
        .sheet(isPresented: $editing) { TimerInspectorView (timer: editingTimer) }
        .navigationBarTitle(title)
        .displayError(view: runningStore)
        .add(self.searchBar)
        .onReceive(searchBar.$text, perform: { text in
            savedTimers.filter = text
            recentStore.filter = text
    
        })

    }
    
    var recentsHorizontalList: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer().frame(width: sideScrollingSpacerSize)
                    ForEach(self.recentStore.filtered, id: \.self) { timer in
                        Menu(content: {
                            ContextMenuPinButton(action: { self.savedTimers.add(timer: timer) } )
                            ContextMenuPlayButton(action: { self.runningStore.start(timer: timer) } )
                            }
                        ) {
                            RecentTimerView(timer: timer)
                                .cornerRadius(sideScrollingCardCornerRadius)
                                .padding(.top)
                                .padding(.bottom, 24)
                                .padding(.horizontal, sideScrollingCardMargin)
                                .shadow(color: colorScheme == .dark ? .clear : Color(.lightGray).opacity(0.5), radius: 10, x: 0, y: 5)
                        }


                    }
                }
                
            }
            .padding(.horizontal, marginPadding)
            .padding(.vertical, verticalMarginPadding)
        }
    }
    
    
    var pinnedTimerList: some View {
        Section {
            pinnedHeader
            
            
            if (self.savedTimers.saved.count == 0) { AddFirstTimerView(action: addTimer) }
            
            ForEach(self.savedTimers.filtered, id: \.id) { timer in
                Button(action: {self.runningStore.start(timer: timer)}) {
                    TimerView(timer: timer, tappable: !isEditable)
                        .contextMenu {
                            ContextMenuDeleteButton { self.savedTimers.remove(timer: timer) }
                            ContextMenuEditButton { edit(timer: timer)}
                            ContextMenuDuplicateButton { self.savedTimers.add(timer: timer) }
                        }
                }
            }
            .onMove { self.savedTimers.move(from: $0, to: $1) }
            .onDelete { self.savedTimers.remove(at: $0) }
        }
    }
    
    var pinnedHeader: some View {
        HStack {
            SectionHeader(text: "Pinned Timers")
            
            Spacer()
            
            if (!self.isEditable) {
                Menu {
                    ContextMenuEditButton { self.isEditable.toggle() }.textCase(nil)
                    ContextMenuAddButton { addTimer() }.textCase(nil)
                } label: {
                    RearrangeButton(action: {})
                }
            }
            else {
                Text("Done")
                    .foregroundColor(UIConstants.Colors.theme)
                    .onTapGesture {
                        withAnimation(.easeInOut) { self.isEditable.toggle() }

                    }
                
            }
        }
    }
    
    //MARK: Functions
    
    func addTimer() {
        self.savedTimers.addNew()
        self.editingIndex = self.savedTimers.saved.endIndex - 1
        self.editing = true
    }
    
    func edit(timer: TogglTimer) {
        self.editingIndex = self.savedTimers.index(of: timer) ?? 0
        self.editing = true
    }

    
    var editingTimer: Binding<TogglTimer> {
        .init (
            get: {self.savedTimers.saved[self.editingIndex]},
            set: {self.savedTimers.set(at: self.editingIndex, timer: $0)}
        )
    }
    
    
    //MARK: Constants
    
    let marginPadding: CGFloat = -20
    let verticalMarginPadding: CGFloat = -7
    let title = "Start a Timer "
    let savedSectionTile = "Pinned Timers"
    let recentsSectionTitle = "Recent Timers"
    let sideScrollingSpacerSize: CGFloat = 20
    let sideScrollingCardCornerRadius: CGFloat = 10
    let sideScrollingCardMargin: CGFloat = 3

}
