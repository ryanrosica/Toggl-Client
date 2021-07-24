//
//  TimeRange.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimeRange: View {
    var timer: TogglTimer
    var body: some View {
        VStack (alignment: .trailing){
            if self.timer.duration != nil && self.timer.duration! > 0 {
                Text("\(UIConstants.Text.format(duration: self.timer.duration!))")
                    .font(UIConstants.Fonts.caption)
                    .foregroundColor(.primary)
            }
            HStack(spacing: 0) {
                if (self.timer.start != nil && self.timer.stop != nil) {
                    Text("\(UIConstants.Text.timeFormat(from: self.timer.start!))")
                        .font(UIConstants.Fonts.caption)
                        .foregroundColor(Color(.secondaryLabel))

                    Text(" - \(UIConstants.Text.timeFormat(from: self.timer.stop!, showAMPM: true))")
                        .font(UIConstants.Fonts.caption)
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
        }
    }
}


