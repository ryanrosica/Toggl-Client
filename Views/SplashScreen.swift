//
//  SplashScreen.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/27/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("ICON")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .padding(80)
    }
}
