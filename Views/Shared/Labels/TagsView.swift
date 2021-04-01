//
//  TagsView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/18/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct TagsView: View {
    var tags: [String]
    var compact = false
    var color: Color

    var body: some View {
        HStack{
            ForEach (tags, id: \.self) { tag in
                Text(tag).font(font).foregroundColor(.primary)
                    .padding(3)
                    .background (
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color(.tertiarySystemFill))
                            .cornerRadius(cornerRadius)

                    )


            }
        }
    }
    
    

    
    //MARK: Constans
    let font: Font = .system(.caption, design: .rounded)
    let opacity = 0.1
    let cornerRadius: CGFloat = 5
}


