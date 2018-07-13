//
//  ProductTableViewCellDelegate.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-12.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol ProductTableViewCellDelegate  {
    /// Action executed when user pressed the button to buy a product
    ///
    /// - Parameter product: Product
    func buttonBuyProductPressed(product: Product)
}

extension ProductTableViewCellDelegate {
    func buttonBuyProductPressed(product: Product){}
}
