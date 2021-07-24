//
//  CloudData.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/23/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

public class CloudData {
    static let shared = CloudData()
    let iCloudDirectory = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
    let localDirectory = FileManager.sharedContainerURL()
    
    private init() {}
    
    var directoryURL: URL {
        if (iCloudDirectory != nil) {
            print("ICLOUD")
            return iCloudDirectory!
        }
        print("LOCAL")

        return localDirectory

    }
    
}

extension FileManager {
  static func sharedContainerURL() -> URL {
    return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: "group.com.ryanrosica.Timer3"
    )!
    
  }
}
