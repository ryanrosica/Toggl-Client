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
