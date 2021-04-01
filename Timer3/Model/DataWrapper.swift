//
//  TogglData.swift
//  Timer2
//
//  Created by Ryan Rosica on 4/30/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

protocol DataWrapper: Codable {
    var encodedData: Data? { get }
}

extension DataWrapper {
    var encodedData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

public struct TogglTimerData: DataWrapper {
    var data: TogglTimer
    
    enum EncodingKeys: String, CodingKey {
          case data = "time_entry"
    }
    
    public func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: EncodingKeys.self)
       try container.encode(data,forKey: .data)
 
    }
}
public struct TogglProjectData: DataWrapper {
    var data: TogglProject
    
    enum EncodingKeys: String, CodingKey {
          case data = "project"
    }
    
    public func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: EncodingKeys.self)
       try container.encode(data,forKey: .data)
 
    }
    
}
public struct TogglUserData: DataWrapper {
    var data: TogglUser
}

