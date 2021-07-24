//
//  DragHandle.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/5/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct DragHandle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundColor(color)
        
    }
    
    //MARK: Constants
    let width: CGFloat = 35
    let height: CGFloat = 6
    let color = Color(.systemFill)
    let cornerRadius: CGFloat = 10
}
