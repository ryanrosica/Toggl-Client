//
//  AddFirstTimerView.swift
//  Timer3
//
//  Created by Ryan Rosica on 6/6/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct AddFirstTimerView: View {
    var action: () -> Void
    var body: some View {
        Text(message)
            .font(UIConstants.Fonts.bodyHeader)
            .foregroundColor(UIConstants.Colors.secondaryFont)
            .onTapGesture {
                self.action()
            }
    }
    
    //MARK: Constants
    let message = "Tap to add your first pinned timer."
}

