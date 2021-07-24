//
//  RearrangeButton.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/23/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct RearrangeButton: View {

    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            Circle()
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: "ellipsis")
                        .font(.system(size: size - padding))
                        .foregroundColor(UIConstants.Colors.theme)
                )
                .foregroundColor(color)
           

        }
        .buttonStyle(ButtonWithoutAnimation())
    }

    //MARK: Constants

    let size: CGFloat = 24
    let padding: CGFloat = 4
    let color = Color(.systemFill)
}

public struct ButtonWithoutAnimation: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
