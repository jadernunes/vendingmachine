//
//  UIColor+Extension.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    /// Will return a UIColor according to the hexadecimal string passed, must be 6 characters long otherwise will return a gray color
    
    /// - Parameter hex: string describing the color in hexadecimal, may have a '#' prepended
    /// - Returns: UIColor for the hexadecimal representation
    class func hexadecimalColor(hex:String) -> UIColor {
        var newString: String = hex.trimmingCharacters(in: .whitespaces).uppercased()
        
        if newString.hasPrefix("#") {
            newString.removeFirst()
        }
        
        if newString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: newString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static var grayLight: UIColor = {
        return UIColor.hexadecimalColor(hex: "#BDBDBD")
    }()
    
    static var graySeparator: UIColor = {
        return UIColor.hexadecimalColor(hex: "#C4C4C4")
    }()
    
    static var base: UIColor = {
        return UIColor.hexadecimalColor(hex: "#DD7212")
    }()
}
