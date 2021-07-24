//
//  AddButton.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/22/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    @Environment(\.colorScheme) var colorScheme
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: iconName)
                .font(.system(size: fontSize))
                .foregroundColor(UIConstants.Colors.theme)
        }
    }
    
    //MARK: Constants
    let iconName = "plus"
    let fontSize: CGFloat = 26
}

