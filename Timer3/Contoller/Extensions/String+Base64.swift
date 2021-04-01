//
//  String+Base64.swift
//  Timer3
//
//  Created by Ryan Rosica on 5/31/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}
