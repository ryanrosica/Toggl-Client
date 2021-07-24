//
//  NowPlayingView.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/26/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct NowPlayingView: View {
    @Binding var open: Bool
    @EnvironmentObject var runningStore: RunningTimerStore
    @Environment(\.colorScheme) var colorScheme

    var showing: Binding<Bool> {
        return .init (
            get: {
                switch (runningStore.state) {
                    case .error(_):
                        return true
                    case .loading:
                        return true
                    case .loaded:
                        if (runningStore.isRunning) {
                            return true
                        }
                        return false
                }
            },
            set: { _ in
                runningStore.stop()
            }
        )
    }
    
    var body: some View {
        sheet
            .onReceive(runningStore.$state, perform: { state in
                if (state == .loaded) {
                    open = false
                }
            })
            .onTapGesture {
                self.open = true
            }
    }
    @ViewBuilder
    var sheet: some View {
        if (runningStore.state == .loaded && runningStore.isRunning) {
            VStack {
                HStack {
                    RunningTimerView()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(colorScheme == .dark ? Color(.tertiarySystemGroupedBackground) : Color(.systemBackground))
                                .shadow(color: colorScheme == .dark ? .clear : Color(.lightGray).opacity(0.5), radius: 5, x: 0, y: 3)
                        )
                }
            }
        }
        
    }
    
    
    //MARK: - Contants
    let maxHeight: CGFloat = 400
    let minHeight: CGFloat = 65
}

