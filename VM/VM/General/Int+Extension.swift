//
//  Int+Extension.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

extension Int {
    /// Change the value from Int to String
    ///
    /// - Returns: return a new value in String format
    func currencyFormat() -> String {
        return String.currencyFormat(value: self)
    }
}
