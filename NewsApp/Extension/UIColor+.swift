//
//  UIColor+.swift
//  NewsApp
//
//  Created by user on 06.11.2021.
//

import Foundation
import UIKit

extension UIColor {
    /// aliceBlue
    static let aliceBlue = UIColor(red: 240, green: 248, blue: 255)
    
    /// Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}
