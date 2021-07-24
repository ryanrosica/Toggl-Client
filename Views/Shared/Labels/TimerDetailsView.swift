//
//  TimerDetails.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimerDetailsView: View {
    var timer: TogglTimer
    var compact = true
    var tags = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.timer.project?.name ?? noPojectText)
                    .font(.system(.body, design: .default))
                    .foregroundColor(.primary)
                if (self.timer.description != nil) {
                    Text(self.timer.description!)
                        .font(.system(.caption, design: .default))
                        .foregroundColor(.primary)
                }
                Spacer().frame(height: spacerHeight)
                if (tags) {
                    
                    TagsView(
                        tags: self.timer.tags ?? [],
                        compact: compact,
                        color: timer.color
                    )
                }
            }
        }
        

    }
    
    //MARK: Constants
    let noPojectText = "No Project"
    let noProjectColor = Color.gray
    let spacerHeight: CGFloat = 2
    
    
}

