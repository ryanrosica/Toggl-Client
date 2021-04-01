//
//  BarEntryDayView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 10/4/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SegmentedBarView: View {
    var model: SegmentedBarViewModel
    
    var body: some View {
        rectangleBar.clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var rectangleBar: some View {
        GeometryReader { geometry in
            HStack (spacing: 0) {
                ForEach(model.segments) { segment in
                    Rectangle()
                        .frame(width: model.widthFrom(segment: segment, totalWidth: geometry.size.width))
                        .foregroundColor(segment.color)
                }
            }
        }

    }
}


