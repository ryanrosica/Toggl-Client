//
//  Store.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/21/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var state: ViewModelState = .loaded

    func recieveCompletion (_ completion: Subscribers.Completion<TogglAPIError>) {
        switch completion {
            case .finished:
                Haptics.success()
                self.state = .loaded
            case .failure(let error):
                self.state = .error(error)
                print(error)
        }
    }
    
    
}
