//
//  App.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/14/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI
import CoreData
//import WidgetKit
@main
struct TogglTimer3App: App {
//    @Environment(\.scenePhase) private var scenePhase
    let persistence = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LoginStore()).environmentObject(RunningTimerStore())
                .onAppear {
                    let font = UIFont.preferredFont(for: .largeTitle, weight: .bold, design: .default)
                    UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
                    UINavigationBar.appearance().tintColor = .systemPink
//                    UITableView.appearance().sectionIndexColor = .clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear

//                    UINavigationBar.appearance().isTranslucent = true

//                    UINavigationBar.appearance().backgroundColor = .systemBackground
                    
//                    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//                    UINavigationBar.appearance().shadowImage = UIImage()
//                    UITabBar.appearance().shadowImage = UIImage()
//                    UITabBar.appearance().backgroundImage = UIImage()
//                    UITabBar.appearance().isTranslucent = true
//                    UITabBar.appearance().backgroundColor =  (.systemBackground)
//                    UINavigationBar.appearance().backgroundColor = .systemBackground

                }
//                .onChange(of: scenePhase) { newScenePhase in
//                    if newScenePhase == .background {
//                        WidgetCenter.shared.reloadTimelines(ofKind: "com.ryanrosica.TogglTimer.RunningWidget")
//                    }
//                }
        }
        
    }
}

class PersistenceManager {
  let persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Timer")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()
}
