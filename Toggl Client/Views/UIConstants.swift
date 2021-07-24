//
//  UIConstants.swift
//  Timer3
//
//  Created by Ryan Rosica on 6/6/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI

struct UIConstants {
    
    struct Colors {
        static let secondaryFont: Color = .gray
        static let theme: Color = Color(.systemPink)
        static let toggl:[[Color]] = [
            [Color(#colorLiteral(red: 0.03127133846, green: 0.5137853026, blue: 0.8444793224, alpha: 1)), Color(#colorLiteral(red: 0.6204479337, green: 0.3559164405, blue: 0.8545953631, alpha: 1)), Color(#colorLiteral(red: 0.8490384817, green: 0.2603727877, blue: 0.5145676732, alpha: 1)), Color(#colorLiteral(red: 0.8903948665, green: 0.4204996228, blue: 0.004774185363, alpha: 1)), Color(#colorLiteral(red: 0.7437489629, green: 0.4405269325, blue: 0, alpha: 1))],
            [Color(#colorLiteral(red: 0.1761326492, green: 0.6483820081, blue: 0.02472382784, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6570599079, blue: 0.5743553042, alpha: 1)), Color(#colorLiteral(red: 0.7810595632, green: 0.5011960268, blue: 0.4191687107, alpha: 1)), Color(#colorLiteral(red: 0.272454828, green: 0.3593876958, blue: 0.7008940578, alpha: 1)), Color(#colorLiteral(red: 0.5960157514, green: 0, blue: 0.6006245017, alpha: 1))],
            [Color(#colorLiteral(red: 0.7848159075, green: 0.6866809726, blue: 0.0724254027, alpha: 1)), Color(#colorLiteral(red: 0.3372724354, green: 0.3979325891, blue: 0.0938019231, alpha: 1)), Color(#colorLiteral(red: 0.599204421, green: 0.06705228239, blue: 0.01647384465, alpha: 1)), Color(#colorLiteral(red: 0.8442254663, green: 0.1655076444, blue: 0.1697567403, alpha: 1)), Color(#colorLiteral(red: 0.3215346932, green: 0.3215956986, blue: 0.3940073252, alpha: 1))],
        ]
    }
    
    
    
    struct Sizes {
        static let cornerRadius: CGFloat = 10
    }

    
    struct Fonts {
        static let header: Font = .system(size: 17, weight: .bold, design: .default)
        static let body: Font = .system(.body, design: .default)
        static let bodyHeader: Font = body.bold()
        static let caption: Font = .system(.callout)
        static let secondaryBody: Font = .system(.caption)
        static let sectionHeader: Font = .system(.title2, design: .default)

    }
    
    struct Text {
        private static func timeFormatter(showAMPM: Bool) -> DateFormatter {
            let df = DateFormatter()
            df.amSymbol = "AM"
            df.pmSymbol = "PM"
            df.dateFormat = "h:mm\(showAMPM ? " a" : "")"
            return df
        }
        private static var dateFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yy"
            return df
        }
        private static var dayFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "EEEE"
            return df
        }
        static func timeFormat (from date: Date, showAMPM: Bool = false) -> String {
            return timeFormatter(showAMPM: showAMPM).string(from: date)
        }
        static func dateFormat (from date: Date) -> String {
            return dateFormatter.string(from: date)
        }
        static func dayFormat(from date: Date) -> String {
            return dayFormatter.string(from: date)
        }
        static func format(duration: Int) -> String {
            let interval = duration

            let formatter = DateComponentsFormatter()

            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .abbreviated

            let formattedString = formatter.string(from: TimeInterval(interval))!
            return (formattedString)
        }

    }
    
}
