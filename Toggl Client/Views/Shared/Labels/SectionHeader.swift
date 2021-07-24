//
//  SectionHeader.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 9/13/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SectionHeader: View {
    var text: String
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(color)
            .textCase(nil)
    }
    
    
    //MARK: Constants
    let font: Font = .system(.title2, design: .default)
    let color = Color.primary
    let fontWeight: Font.Weight = .bold
}

