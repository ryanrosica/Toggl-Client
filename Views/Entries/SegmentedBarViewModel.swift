//
//  SegmentedBarViewModel.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 10/4/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SegmentedBarViewModel {
    var segments: [Segment]
    
    var total: Int { segments.map (\.weight).reduce(0,+) }
    
    func widthFrom(segment: Segment, totalWidth: CGFloat) -> CGFloat {
        guard let segmentIndex = segments.firstIndex(where: { $0.id == segment.id }) else {
            print("NO WIDTH BAR")

            return 0
        }
        return (CGFloat(segments[segmentIndex].weight) / CGFloat(total)) * CGFloat(totalWidth)
    }
    
}

struct Segment: Identifiable {
    var title: String
    var color: Color
    var weight: Int
    var id: String {
        title
    }
}



