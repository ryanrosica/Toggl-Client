//
//  TabView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI
struct TabsView: View {
    @Namespace var namespace

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
        Tab(view: entriesView, title: "Entries", image: "calendar")
        Tab(view: reportsView, title: "Reports", image: "chart.bar.fill")
        Tab(view: acccount, title: "Account", image: "person.crop.circle.fill")
        Tab(view: settingsView, title: "Settings", image: "gear")
    }
    
    var entriesView: some View {
        EntriesView(entriesStore: TimeEntriesStore())
            .navigationTitle("Reports")
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
//            .toolbar {
//                ToolbarItem(placement: .bottomBar) {
//                    RunningTimerView()
//                }
//            }
//            .overlay(nowPlayingView.matchedGeometryEffect(id: "now", in: namespace))
        

    }
    
    var acccount: some View {
        List {
            ProfileRow(name: UserStore.shared.user?.fullname ?? "", email: UserStore.shared.user?.email ?? "")
            ManageAccountView()
        }
//        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                RunningTimerView()
//            }
//        }
//        .overlay(nowPlayingView.matchedGeometryEffect(id: "now", in: namespace))
        .navigationTitle("Profile")

    }
    
    var homeView: some View {
        HomeView(savedTimers: savedStore, recentStore: RecentTimersStore()).navigationTitle("Home")
//            .toolbar {
//                ToolbarItem(placement: .status) {
//                    RunningTimerView()
//                        .frame(height:80)
//
//                }
//
//            }
//            .overlay(nowPlayingView.matchedGeometryEffect(id: "now", in: namespace))

    }
    var settingsView: some View {
        SettingsView(savedTimersStore: savedStore)
//            .toolbar {
//                ToolbarItem(placement: .bottomBar) {
//                    RunningTimerView()
//                }
//            }
//            .overlay(nowPlayingView.matchedGeometryEffect(id: "now", in: namespace))

    }
    
    var reportsView: some View {
        ReportsView()
//            .toolbar {
//                ToolbarItem(placement: .bottomBar) {
//                    RunningTimerView()
//                }
//            }
//            .overlay(nowPlayingView.matchedGeometryEffect(id: "now", in: namespace))

    }
    
    
    @ViewBuilder
    var nowPlayingView: some View {
        NowPlayingView(open: $sheet)
    }
}





