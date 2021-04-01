//
//  Tab.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct Tab <T: View>: View {
    var view: T
    var interface = UIDevice.current.userInterfaceIdiom
    var title: String
    var image: String
    
    @ViewBuilder
    var body: some View {
        if (interface == .pad) {
            NavigationLink(destination: view) {
                Label(title, systemImage: image)
            }
        }
        else {
            NavigationView {view}
                .tabItem {
                    Image(systemName: image)
                    Text(title)
                }
        }
    }
}
