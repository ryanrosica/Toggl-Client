//
//  TabView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI
struct TabsView: View {
    let savedStore = SavedTimersStore()
    @State var sheet = false
    
    @ViewBuilder
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            SideBar(view: tabs, title: title, accent: UIConstants.Colors.theme)
        } else {
            BottomBar(view: tabs, accent: UIConstants.Colors.theme)
        }
    }
    
    //MARK: Constants
    let title = "Timer"
}

extension TabsView {
    @ViewBuilder
    var tabs: some View {
        Tab(view: homeView, title: "Home", image: "house.fill")
        Tab(view: reportsView, title: "Entries", image: "chart.bar.fill")
        Tab(view: settingsView, title: "Settings", image: "gear")
    }
    
    var reportsView: some View {
        EntriesView(entriesStore: TimeEntriesStore())
            .navigationTitle("Reports")
            
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            .overlay(nowPlayingView)
        

    }
    
    var homeView: some View {
        HomeView(savedTimers: savedStore, recentStore: RecentTimersStore()).navigationTitle("Home")
            .overlay(nowPlayingView)

    }
    var settingsView: some View {
        SettingsView(savedTimersStore: savedStore)
            .overlay(nowPlayingView)

    }
    
    @ViewBuilder
    var nowPlayingView: some View {
        NowPlayingView(open: $sheet)
    }
}





