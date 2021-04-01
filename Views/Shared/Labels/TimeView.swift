//
//  TimeView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    var timer: TogglTimer
    @State var duration = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentTime: String?

    var body: some View {
        Text("\(currentTime ?? timer.currentTime)")
            .onReceive(duration, perform: {_ in
                self.currentTime = self.timer.currentTime
            })
            .font(UIConstants.Fonts.body)
            .foregroundColor(UIConstants.Colors.secondaryFont)
            .frame(width: width)
    }
    
    //MARK: Constants
    let width: CGFloat = 80
}



