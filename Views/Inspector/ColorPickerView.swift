//
//  ColorPickerView.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/29/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct ColorPickerView: View {
    var colors: [[Color]]
    @Binding var selected: Int?
    var selectedRow: Int? {
        guard let selected = selected else { return nil }
        return (selected / colors[0].count)
    }
    var selectedCol: Int? {
        guard let selected = selected else { return nil }
        return (selected % colors[0].count)
    }
    
    var body: some View {
        VStack (spacing: 20) {
            ForEach(0..<colors.count, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<self.colors[0].count, id: \.self) { colIndex in
                        Image(systemName: (rowIndex == self.selectedRow && colIndex == self.selectedCol) ? "checkmark.circle.fill" : "circle.fill")
                            .foregroundColor(self.colors[rowIndex][colIndex])
                            .font(.system(size: 40))
                            .onTapGesture {
                                self.selected = rowIndex * self.colors[0].count + colIndex
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemFill))
        .cornerRadius(20)
        .padding()

    }
}

