//
//  Money.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-12.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

struct Money {
    
    /// Shared instance (Singleton)
    static var shared = Money()
    private var amount: Variable<Int> = Variable<Int>(0)
    
    public mutating func addAmount(amount: Int, completion: @escaping ((Bool, String) -> Void)){
        //TODO: Validate role
        if (self.amount.value + amount) <= 100 {
            self.amount.value += amount
            completion(true, "")
        } else {
            completion(false,"The limite is $1,00")
        }
    }
    
    public func getAmount() -> Variable<Int> {
        return self.amount
    }
    
    public func setAmount(value: Int) {
        self.amount.value = value
    }
    
    public func resetAmount() {
        self.amount.value = 0
    }
}
