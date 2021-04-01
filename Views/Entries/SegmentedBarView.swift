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


struct SegmentedBarView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedBarView(
            model: .init(
                segments: [
                    Segment(title: "1", color: .red, weight: 3),
                    Segment(title: "2", color: .blue, weight: 4),
                    Segment(title: "3", color: .green, weight: 2),
                    Segment(title: "9", color: .orange, weight: 3)
                ]
            
            )
        )
    }
}
