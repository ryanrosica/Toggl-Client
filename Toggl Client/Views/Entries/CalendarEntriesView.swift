//
//  CalendarEntriesView.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 2/8/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import SwiftUI

struct CalendarEntriesView: View {
    @ObservedObject var entriesStore: TimeEntriesStore

    func height(totalHeight: CGFloat) -> CGFloat{
        return totalHeight / 24
    }
    var body: some View {
        ScrollViewReader { value in
            GeometryReader { geometry in
                ZStack (alignment: .top){
                    ForEach(1..<24) { i in
                        VStack {
                            Spacer().frame(height: height(totalHeight: geometry.size.height) * CGFloat(i))

                            
                            HStack {
                                Text(String(i))
                                Spacer()
                            }
                        }
                        
                        

                    }
                    
                    ForEach(entriesStore.calEvents + entriesStore.entries, id: \.id) { timer in
                        if timer.stop != nil {
                            EmptyView()
                            HStack {
                                Spacer().frame(width: 50)
                                VStack {
                                    Spacer()
                                        .frame(height: (CGFloat)(entriesStore.startAndEndPercentages(timer: timer)!.0) * geometry.size.height )
                                    CalendarBlock(
                                        timer: timer,
                                        size: (CGFloat)((entriesStore.startAndEndPercentages(timer: timer)!.1
                                                - entriesStore.startAndEndPercentages(timer: timer)!.0)) * geometry.size.height
                                    )
                                }
                            }



                        }


                    }
                }
            }
        }
 


    }
}
struct CalendarBlock: View {
    var timer: TimeBlock
    var size: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(timer.color.opacity(0.5))
            .overlay(details)
            .frame(height: size)
    }
    
    var details: some View {
        Text(timer.name)
            
    }
}
