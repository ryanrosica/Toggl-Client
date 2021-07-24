//
//  CalendarCellView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/4/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct CalendarCellView: View {

    var selected: Bool
    var number: Int
    var tappable = false
    var label: String
    var body: some View {
        Circle()
            .overlay(dayLabel)
            .foregroundColor(selected ? selectedBackground : ((tappable) ? notSelectedBackground : notTappableColor))
    }
    
    var dayLabel: some View {
        Text("\(number)")
            .foregroundColor(selected ? selectedFontColor : ((tappable) ? notSelectedFontColor : .gray))
            .font(UIConstants.Fonts.body)
            .layoutPriority(1)
    }
    
    
    let selectedBackground = UIConstants.Colors.theme
    let notSelectedBackground = Color(.clear)
    let notSelectedFontColor = Color.primary
    let selectedFontColor = Color.white
    let notTappableColor = Color(.clear)
    let widthThreshold: CGFloat = 80
    let numberWeight: Font.Weight = .black
}


