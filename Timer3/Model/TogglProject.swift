//
//  TogglProject.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/1/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import SwiftUI

struct TogglProject: TogglObject, Identifiable, Equatable {
    var name: String?
    var id: Int = UUID().hashValue
    var wid: Int?
    var hex_color: String?
    var server_deleted_at: String?
    var colorID: Int?
    var deleted: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case wid = "wid"
        case server_deleted_at = "server_deleted_at"
        case hex_color = "hex_color"
        case colorID = "color"
    }
    
    func color() -> Color {
        return Color(UIColor.hexStringToUIColor(hex: hex_color ?? ""))
    }
    
    static func == (first: TogglProject, second: TogglProject) -> Bool {
        return
            first.id == second.id
    }

}

extension TogglProject {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        deleted = try values.decodeIfPresent(String.self, forKey: .server_deleted_at) == nil
        id = try values.decode(Int.self,forKey: .id)
        wid = try values.decode(Int?.self,forKey: .wid)
        name = try values.decode(String?.self,forKey: .name)
        if let colorIDString: String = try values.decode(String?.self, forKey: .colorID) {
            colorID = Int(colorIDString)
        }
        
        hex_color = try values.decode(String?.self,forKey: .hex_color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wid, forKey: .wid)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(hex_color, forKey: .hex_color)
        try container.encode(String(colorID ?? 0), forKey: .colorID)
    }

}
