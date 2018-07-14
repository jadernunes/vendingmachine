//
//  ViewController.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    //MARK: - Variables
    
    /// ViewModel to represent the data
    private var viewModel: ListProductViewModel = ListProductViewModel()
    private var disposeBag = DisposeBag()
    private let heightViewMoney = CGFloat(150)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.base
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = appName
        self.addNavigationBarButtons()
        
        //Initial Setup
        Utils.initialSetup { _ in
            self.setupViewModel()
        }
    }
    
    //MARK: - Custom methods
    
    private func setupViewModel(){
        viewModel.products.asObservable().subscribe({ products  in
            guard let products = products.element else {
                //TODO: If will be request something on API we have to implement a error View
                return
            }
            
            self.addViewMoney()
            self.addViewListProducts(products: products)
            
        }).disposed(by: self.disposeBag)
        
        getAllProducts()
    }
    
    /// Add a view to show the current amount
    private func addViewMoney(){
        if let viewMoney = MoneyView.initFromNib() {
            let frameViewMoney = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.heightViewMoney)
            viewMoney.frame = frameViewMoney
            self.view.addSubview(viewMoney)
        }
    }
    
    /// Add a view to list all products
    ///
    /// - Parameter products: List of Products(Availalbe and Lacking)
    private func addViewListProducts(products: [Product]){
        let frameViewResult = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + self.heightViewMoney, width: self.view.frame.size.width, height: self.view.frame.size.height - self.heightViewMoney)
        let viewResult = ListProductsView(frame: frameViewResult, products: products, delegate: self)
        self.view.addSubview(viewResult)
    }
    
    /// Get all products on database
    private func getAllProducts(){
        viewModel.getAllProducts()
    }
    
    /// Setup navigation bar
    private func addNavigationBarButtons() {
        let buttonReset = UIBarButtonItem(
            image: UIImage(named: "iconReset"),
            style: .plain,
            target: self,
            action: #selector(self.buttonResetPressed)
        )
        
        self.navigationItem.setLeftBarButtonItems([buttonReset], animated: true)
    }
}

extension ViewController {
    
    @objc func buttonResetPressed(){
        let alert = UIAlertController(title: "Caution", message: "Are you sure that you want to reset all data?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default) { _ in
            self.viewModel.resetAllData()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "NO", style: .destructive) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: ProductTableViewCellDelegate {
    func buttonBuyProductPressed(product: Product) {
        self.viewModel.decreaseProduct(product: product) { (products: [Product], success: Bool, message: String) in
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                alert.dismiss(animated: true, completion: nil)
            })
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}
