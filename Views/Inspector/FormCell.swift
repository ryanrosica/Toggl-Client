//
//  FormCell.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/20/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct FormCell<Content>: View where Content: View {
    var label: String
    var content: Content
    var image: String?
    @State var tint: Color = UIConstants.Colors.theme
    var body: some View {
        HStack(spacing: hstackSpacing) {
            if(image != nil) {
                Image(systemName: image ?? "")
                    .frame(width: iconWidth, height: iconWidth)
                    .foregroundColor(.white)
                    .padding(imagePadding)
                    .background(tint)
                    .mask (
                        RoundedRectangle(cornerRadius: cornerRadius)
                    )
                    .transition(AnyTransition.identity)


            }
            Text(label)
                .font(UIConstants.Fonts.bodyHeader)
                .foregroundColor(.primary)
                .fixedSize()

            Spacer()
            content
                .foregroundColor(.gray)

       }
        .frame(height: height)
    }
    
    let height: CGFloat = 40
    let hstackSpacing: CGFloat = 13
    let iconWidth: CGFloat = 20
    let cornerRadius: CGFloat = 5
    let imagePadding: CGFloat = 4
}

