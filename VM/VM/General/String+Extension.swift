//
//  String+Extension.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

extension String {
    
    /// Use to format price Int in monetary value
    ///
    /// - Parameters:
    ///   - value: price in Int format
    ///   - prefix: If exist: e.g: $0,10
    ///   - sufix: If exist: e.g: 0,10xx
    /// - Returns: return a new value with a prefix + sufix
    static func currencyFormat(value:Int, prefix:String?=nil, sufix:String?=nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_CA")
        
        let value = Double(value)/100
        
        var newValue : String = formatter.string(from: NSNumber(value: value)) ?? ""
        if let prefix : String = prefix {
            newValue = prefix + newValue
        }
        if let sufix : String = sufix {
            newValue = newValue + sufix
        }
        return newValue
    }
}
