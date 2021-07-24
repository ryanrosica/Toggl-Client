//
//  ActionButton.swift
//  Timer3
//
//  Created by Ryan Rosica on 7/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
    var name: String
    var action: () -> Void

    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(UIConstants.Colors.theme)
                .overlay(Text(name).foregroundColor(fontColor))
                .frame(height: height)
                .padding()
                .textCase(nil)

            
        }
    }
    
    //MARK: Constants
    
    let height: CGFloat = 60
    let cornerRadius: CGFloat = 10
    let fontColor: Color = .white
}

struct SecondaryActionButton: View {
    var name: String
    var action: () -> Void

    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(background)
                .overlay(Text(name).foregroundColor(fontColor))
                .frame(height: height)
                .padding()
            
        }
    }
    
    //MARK: Constants
    
    let height: CGFloat = 60
    let cornerRadius: CGFloat = 10
    let fontColor: Color = UIConstants.Colors.theme
    let background: Color = Color(.systemFill)
}


