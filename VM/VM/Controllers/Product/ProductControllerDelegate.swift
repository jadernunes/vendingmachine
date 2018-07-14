//
//  ProductControllerDelegate.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol ProductControllerDelegate  {
    
    /// The alias to represent the closure of the Model
    typealias ProductsCompletion = (([Product]) -> Void)
    
    /// The alias to represent the closure
    typealias DecreaseProductCompletion = (([Product], Bool, String) -> Void)
    
    /// Get new Model updated
    ///
    /// - Parameter completion: return a completion response
    func getAllProducts(completion: @escaping ProductsCompletion)
    
    /// Reset all products on database
    ///
    /// - Parameter completion: List of Products
    func resetAllData(completion: @escaping ProductsCompletion)
    
    /// Used to decrease the product quantity
    ///
    /// - Parameters:
    ///   - product: Product to decrease
    ///   - completion: List of Products
    func decreaseProduct(product: Product, completion: @escaping DecreaseProductCompletion)
}
