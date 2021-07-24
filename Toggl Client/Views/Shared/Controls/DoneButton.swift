//
//  DoneButton.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/6/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct DoneButton: View {

    var action: () -> Void
    
    var body: some View {
        Button (action: action) {
            Text(text)
                .font(UIConstants.Fonts.body)
                .foregroundColor(UIConstants.Colors.theme)
        }
    }
    
    //MARK: Constants
    let text = "Done"
}
