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
    let persistence = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LoginStore()).environmentObject(RunningTimerStore())
                .onAppear {
                    let font = UIFont.preferredFont(for: .largeTitle, weight: .bold, design: .default)
                    UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
                    UINavigationBar.appearance().tintColor = .systemPink
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
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
