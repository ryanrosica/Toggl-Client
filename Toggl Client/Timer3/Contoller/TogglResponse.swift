//
//  TogglResponse.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/1/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation

enum TogglResponse<T> {
    case error(TogglError)
    case success(T)
}
