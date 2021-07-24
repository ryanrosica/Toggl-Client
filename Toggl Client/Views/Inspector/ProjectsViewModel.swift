//
//  ProjectsViewModel.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 11/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

class ProjectsViewModel: ObservableObject {
    let userStore = UserStore.shared
    
    var filter: String = "" {
        didSet {
            projects = userStore.user?.projects?.filter {
                if filter == "" { return true }
                
                return $0.name?.contains(filter) ?? true
            }
        }
    }
    
    
    @Published var projects: [TogglProject]? = UserStore.shared.user?.projects
        
    
    
    
    
}
