//
//  UIFont+preferredFont.swift
//  Timer3
//
//  Created by Ryan Rosica on 6/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight, design: UIFontDescriptor.SystemDesign) -> UIFont {
        let size = UIFont.preferredFont(forTextStyle: style).pointSize
        let desc = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(.default)!
        let font = UIFont(descriptor: desc, size: size)
        return font
    }
}
