//
//  TogglTimer3MacApp.swift
//  TogglTimer3Mac
//
//  Created by Ryan Rosica on 11/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

import SwiftUI
//import WidgetKit
@main
struct TogglTimer3MacApp: App {
//    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LoginStore()).environmentObject(RunningTimerStore())
                .onAppear {
                    let font = UIFont.preferredFont(for: .largeTitle, weight: .bold, design: .default)
                    UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
                    UINavigationBar.appearance().tintColor = .systemPink
                        

                }
//                .onChange(of: scenePhase) { newScenePhase in
//                    if newScenePhase == .background {
//                        WidgetCenter.shared.reloadTimelines(ofKind: "com.ryanrosica.TogglTimer.RunningWidget")
//                    }
//                }
        }
        
    }
}
