//
//  StopButton.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/18/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct StopButton: View {
    var loading: Bool
    var color: Color
    var action: () -> Void
    
    @ViewBuilder
    var body: some View {
        if (loading) {
            ProgressView()
        }
        else {
            Image(systemName: iconName)
                .foregroundColor(loading ? Color(.systemFill) : color)
                .onTapGesture {
                    if (!loading) {
                        self.action()
                    }
                }
                .font(.system(size: 35))
            
        }
    }
    
    //MARK: Constants
    let iconName = "stop.circle.fill"
    
    
}



