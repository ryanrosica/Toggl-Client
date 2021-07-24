//
//  ProjectSummary.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 4/15/21.
//  Copyright © 2021 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Charts

struct TogglReportSummaryData: TogglObject, Identifiable {
    var id = UUID().hashValue
    var total: Int
    var summaries: [TogglReportSummary]
}

extension TogglReportSummaryData {
    
    
    enum CodingKeys: String, CodingKey {
        case total = "total_grand"
        case data = "data"

    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        total = try values.decode(Int.self ,forKey: .total)
        summaries = try values.decode([TogglReportSummary].self, forKey: .data)
        print("DATA DECODED")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(total, forKey: .total)
    }
}




struct TogglReportSummary: TogglObject, Identifiable  {
    var id = UUID().hashValue
    private var details: TogglReportSummaryDetails
    var time: Int
    
    var title: String {
        let tags = details.tag ?? ""
        let projects = details.project ?? ""
        return projects + " " + tags
    }
    var color: Color {
        return details.color ?? .gray
    }
    
}

extension TogglReportSummary {
    enum CodingKeys: String, CodingKey {
        case details = "title"
        case time = "time"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        details = try values.decode(TogglReportSummaryDetails.self ,forKey: .details)
        time = try values.decode(Int.self, forKey: .time)
        print("SUMMARY DECODED")

    }
    
    
    func encode(to encoder: Encoder) throws {}
}



struct TogglReportSummaryDetails: TogglObject, Identifiable {
    var id = UUID().hashValue
    var project: String?
    var tag: String?
    var color: Color?
}


extension TogglReportSummaryDetails {
    enum CodingKeys: String, CodingKey {
        case tag = "tag"
        case project = "project"
        case color = "hex_color"

    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        project = try? values.decodeIfPresent(String.self ,forKey: .project)
        tag = try? values.decodeIfPresent(String.self, forKey: .tag)
        let color = try? values.decodeIfPresent(String.self, forKey: .color)
        self.color = Color(UIColor.hexStringToUIColor(hex: color ?? "0"))
        print("DETAILS DECODED")

    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}
