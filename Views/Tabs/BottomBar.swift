//
//  BottomBar.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/15/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct BottomBar<T: View>: View {
    var view: T
    var accent: Color
    
    var body: some View {
        TabView {
            view
        }
        .accentColor(accent)
    }
}
