//
//  ListProductsView.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

class ListProductsView: UITableView {
    
    //MARK: - Variables
    
    private var productsAvailable: [Product] = []
    private var productsLacking: [Product] = []
    private var productCellIdentifier = "ProductTableViewCell"
    private var productXibName = "ProductTableViewCell"
    private var delegateProductCell: ProductTableViewCellDelegate?
    
    //MARK: - Life Cycle
    
    convenience init(frame: CGRect, products: [Product] = [], delegate: ProductTableViewCellDelegate) {
        self.init(frame: frame, style: .plain)
        
        setupUI()
        loadProducts(products: products)
        self.delegateProductCell = delegate
    }
    
    //MARK: - Custom methods
    
    /// Initial configuration of the UI
    private func setupUI(){
        self.register(UINib.init(nibName: productXibName, bundle: Bundle.main), forCellReuseIdentifier: productCellIdentifier)
        
        self.delegate = self
        self.dataSource = self
        self.estimatedRowHeight = 1000
        self.allowsSelection = false
        self.separatorStyle = .none
    }
    
    /// Load products data
    ///
    /// - Parameter products: List of Products
    private func loadProducts(products: [Product]){
        self.productsAvailable = products.filter({ $0.getQuantity().value > 0 })
        self.productsLacking = products.filter({ $0.getQuantity().value == 0 })
        self.reloadData()
    }
}

//MARK: - TableView Delegate

extension ListProductsView: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.productsLacking.count > 0 {
            return 2
        }
        
        return 1
    }
}

//MARK: - TableView DataSource

extension ListProductsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.productsAvailable.count
        } else {
            return self.productsLacking.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier,for: indexPath) as? ProductTableViewCell
            else { return UITableViewCell() }
        
        let product = indexPath.section == 0 ? self.productsAvailable[indexPath.row] : self.productsLacking[indexPath.row]
        cell.product = product
        cell.delegate = self.delegateProductCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Available"
        }
        
        return "Lacking"
    }
}
