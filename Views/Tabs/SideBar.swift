//
//  SideBar.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SideBar<T: View>: View {
    var view: T
    var title: String
    var accent: Color
    
    var body: some View {
        NavigationView {
            List {
                view
                ManageAccountView()
            }
            .navigationTitle(title)
            .listStyle(SidebarListStyle())
        }
        .accentColor(accent)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
