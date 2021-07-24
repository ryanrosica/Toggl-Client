//
//  ProfileRow.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 12/21/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ProfileRow: View {
    var name: String
    var email: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .foregroundColor(UIConstants.Colors.theme)
                .font(.system(size: 30))
            VStack (alignment: .leading) {
                Text(name)
                    .font(UIConstants.Fonts.body)
                Text(email)
                    .font(UIConstants.Fonts.secondaryBody)
            }

        }
        .padding(.vertical)
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(name: "Ryan Rosica", email: "ryanrosica@gmail.com")
    }
}
