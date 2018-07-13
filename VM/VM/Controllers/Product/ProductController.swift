//
//  ProductController.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

class ProductController: ProductControllerDelegate {
    
    /// Get all products on database
    ///
    /// - Parameter completion: List of Products
    func getAllProducts(completion: @escaping ProductsCompletion) {
        Product.allObjects(completion: completion)
    }
    
    /// Reset all products on database
    ///
    /// - Parameter completion: List of Products
    func resetAllData(completion: @escaping ProductsCompletion) {
        Utils.resetMachine(completion: completion)
    }
    
    /// Decrease the quantity of the product
    ///
    /// - Parameters:
    ///   - product: Product to buy
    ///   - completion: List of Product updated
    func decreaseProduct(product: Product, completion: @escaping DecreaseProductCompletion) {
        let currentProduct = product
        let currentAmount = Money.shared.getAmount().value
        if currentAmount >= product.getPrice().value {
            Product.update(object: product, value: product.getQuantity().value-1, key: "quantity") { (success: Bool, product: Product?) in
                Product.allObjects(completion: { (products:[Product]) in
                    let chargeValue = currentAmount - currentProduct.getPrice().value
                    let chargeMessage = chargeValue > 0 ? "and your charge is: \(chargeValue.currencyFormat())." : ""
                    completion(products,true, "Thank's! \n You can get the product: \(currentProduct.getName().value) \(chargeMessage)")
                })
            }
        } else {
            Product.allObjects(completion: { (products:[Product]) in
                let chargeMessage = currentAmount > 0 ? "\nPlease get your money: \(currentAmount.currencyFormat())." : ""
                completion(products,false, "Sorry, insufficient amount! \(chargeMessage)")
            })
        }
        
        Money.shared.resetAmount()
    }
}
