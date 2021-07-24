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
    @State var sheet = false

    
    var body: some View {
        TabView {
            view
        }

        .overlay(nowPlayingView)
        .accentColor(accent)
    }
    
    var nowPlayingView: some View {
        VStack {
            Spacer()
            NowPlayingView(open: $sheet)
                .frame(width: 350)
            Spacer().frame(height: 60)
        }


    }
}
