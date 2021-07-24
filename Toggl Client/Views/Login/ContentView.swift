//
//  ContentView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: LoginStore
    @ViewBuilder
    var body: some View {
        if !(store.isLoggedIn ?? true) { LoginView() }
        else if store.isLoggedIn ?? false { TabsView() }
        else { SplashScreen() }
    }
}

