//
//  ViewModelState.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

enum ViewModelState: Equatable {
    case loading
    case error (TogglAPIError)
    case loaded
}
