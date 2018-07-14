//
//  Product.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class Product: BaseModel, CustomModelProtocol {
    
    @objc private dynamic var idProduct: Int = 0
    @objc private dynamic var name: String = ""
    @objc private dynamic var price: Int = 0
    @objc private dynamic var quantity: Int = 0
    @objc private dynamic var desc: String = ""
    
    open override static func primaryKey() -> String? {
        return "idProduct"
    }
    
    func getPrimaryKey() -> Variable<Int> {
        return Variable<Int>(idProduct)
    }
    
    func getName() -> Variable<String> {
        return Variable<String>(name)
    }
    
    func getPrice() -> Variable<Int> {
        return Variable<Int>(price)
    }
    
    func getQuantity() -> Variable<Int> {
        return Variable<Int>(quantity)
    }
    
    func getDescription() -> Variable<String> {
        return Variable<String>(desc)
    }
}
