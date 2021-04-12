//
//  SavedTimerView.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/6/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    var timer: TogglTimer
    var tappable: Bool
    var isRunning = false
    @EnvironmentObject var runningStore: RunningTimerStore
    
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 2)
                .font(.system(size: 46))
                .foregroundColor(timer.project?.color())
                .frame(width: isRunning ? 80 : 6)
                .frame(height: isRunning ? 30 : nil)
                .overlay(
                    isRunning ?
                        AnyView(TimeView(timer: runningStore.runningTimer ?? TogglTimer(), color: .white)) : AnyView(EmptyView())
                )
            TimerDetailsView(timer: self.timer)
            Spacer()
            if(tappable) {
                Image(systemName: secondaryImage)
                    .foregroundColor(imageColor)
                    .font(imageFont)
            }
        }
        .frame(height: height)
        .padding(.vertical, 6)
        .background(Color(.clear))
    }
    
    //MARK: Constants
    
    let height: CGFloat = 50
    let padding: CGFloat = 8
    let imageSize: CGFloat = 28
    let image = "pin.circle.fill"
    let secondaryImage = "play.fill"
    let imageColor = Color(.gray)
    let imageFont = Font.system(size: 16)
    let loadingColor: Color = .gray
}


struct RecentTimerView: View {
    var timer: TogglTimer
    var compact = true
    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                    .foregroundColor(timer.project?.color() ?? .gray)
                    .font(imageFont)
                    .padding(2)
                Spacer()
            }

            HStack(spacing: 12) {
                TimerDetailsView(timer: self.timer, compact: compact)
                Spacer()
            }
        }
        .frame(height: height )
        .frame(width: width)
        .frame(minWidth: height)
        .padding(padding)
        .background(Color(.secondarySystemGroupedBackground))
    }
    
    //MARK: Constants
    
    let height: CGFloat = 95
    let padding: CGFloat = 8
    let width: CGFloat = 200
    let image = "clock.fill"
    let imageFont: Font = .system(size: 18, weight: .heavy, design: .default)
    let imageSize: CGFloat = 28
}

