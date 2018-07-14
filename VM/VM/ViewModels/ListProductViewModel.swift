//
//  ListProductViewModel.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListProductViewModel {
    
    /// The alias to represent the closure
    typealias DecreaseProductCompletion = (([Product], Bool, String) -> Void)
    
    /// Controller protocol reference
    private let delegate: ProductControllerDelegate
    
    /// Contains a list of Products
    var products: Variable<[Product]> = Variable<[Product]>([])
    
    /// Initialize the ViewModel with a delegate if it'll be necessary
    ///
    /// - Parameter delegate: Optional ProductController protocol reference. You can override it if will be necessary
    init(delegate: ProductControllerDelegate = ProductController()) {
        self.delegate = delegate
    }
    
    /// Request all products to View Model
    func getAllProducts(){
        self.delegate.getAllProducts { [unowned self] (products: [Product]) in
            self.products.value = products
        }
    }
    
    /// Reset all products data
    func resetAllData(){
        self.delegate.resetAllData { [unowned self] (products: [Product]) in
            self.products.value = products
        }
    }
    
    /// Decrease the quantity of the product chosen
    ///
    /// - Parameter product: Product
    func decreaseProduct(product: Product, completion: @escaping DecreaseProductCompletion) {
        self.delegate.decreaseProduct(product: product) { (products: [Product], success: Bool, message: String) in
            self.products.value = products
            completion(products,success,message)
        }
    }
}
