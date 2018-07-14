//
//  ProductTableViewCell.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var constraintHeightSeparator: NSLayoutConstraint!{
        didSet {
            constraintHeightSeparator.constant = 0.5
        }
    }
    
    @IBOutlet weak var constraintWidthButtonPlus: NSLayoutConstraint!{
        didSet {
            constraintWidthButtonPlus.constant = 0
        }
    }
    
    @IBOutlet weak var viewSeparator: UIView!{
        didSet {
            viewSeparator.backgroundColor = UIColor.graySeparator
        }
    }
    
    @IBOutlet weak var labelTitle: UILabel!{
        didSet {
            labelTitle.text = ""
        }
    }
    
    @IBOutlet weak var labelDescription: UILabel!{
        didSet {
            labelDescription.text = ""
            labelDescription.textColor = UIColor.grayLight
        }
    }
    
    @IBOutlet weak var labelPrice: UILabel!{
        didSet {
            labelPrice.text = ""
        }
    }
    
    @IBOutlet weak var buttonPlus: UIButton!{
        didSet {
            buttonPlus.setImage(nil, for: .normal)
        }
    }
    
    @IBOutlet weak var labelTitleQuantity: UILabel!{
        didSet {
            labelTitleQuantity.text = "Unit: "
        }
    }
    
    @IBOutlet weak var labelQuantity: UILabel!{
        didSet {
            labelQuantity.text = ""
        }
    }
    
    //MARK: - Variables
    
    var delegate: ProductTableViewCellDelegate?
    var product: Product! {
        didSet {
            self.labelTitle.text = product.getName().value
            self.labelPrice.text = product.getPrice().value.currencyFormat()
            self.labelDescription.text = product.getDescription().value
            self.labelQuantity.text = product.getQuantity().value.description
            
            if product.getQuantity().value > 0 {
                let icon = UIImage(named: "iconCheckout")
                buttonPlus.setImage(icon, for: .normal)
                buttonPlus.imageView?.contentMode = .scaleToFill
                constraintWidthButtonPlus.constant = 50
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func buttonPlusPressed(_ sender: UIButton) {
        self.delegate?.buttonBuyProductPressed(product: self.product)
    }
    
}
