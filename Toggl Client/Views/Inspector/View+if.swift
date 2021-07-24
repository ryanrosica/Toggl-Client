//
//  View+if.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 3/18/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
  @ViewBuilder
  func `if`<Transform: View>(
    _ condition: Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
