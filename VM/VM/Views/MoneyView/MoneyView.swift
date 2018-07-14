//
//  MoneyView.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-12.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MoneyView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet weak var buttonAbort: UIButton!{
        didSet{
            self.buttonAbort.alpha = 0.0
            buttonAbort.setTitle("Abort", for: .normal)
        }
    }
    @IBOutlet weak var labelTitleAmount: UILabel!{
        didSet{
            labelTitleAmount.text = "Money: "
        }
    }
    
    @IBOutlet weak var labelAmount: UILabel!{
        didSet {
            Money.shared.getAmount().asObservable().subscribe({ amount  in
                guard let amount = amount.element, amount > 0 else {
                    self.labelAmount.text = 0.currencyFormat()
                    self.buttonAbort.alpha = 0.0
                    return
                }
                self.labelAmount.text = amount.currencyFormat()
                self.buttonAbort.alpha = 1
                
            }).disposed(by: self.disposeBag)
        }
    }
    
    @IBOutlet weak var buttonAddAmount: UIButton!{
        didSet {
            buttonAddAmount.tintColor = UIColor.base
        }
    }
    
    //MARK: - Variables
    
    private var disposeBag = DisposeBag()
    
    @IBAction func buttonAbortPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Caution", message: "Are you sure that you want to abort?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default) { _ in
            Money.shared.resetAmount()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "NO", style: .destructive) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonAddAmountPressed(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: "Amount Options", message: nil, preferredStyle: .actionSheet)
        
        //$0,05
        let option5cents = UIAlertAction(title: 5.currencyFormat(), style: .default) { _ in
            Money.shared.addAmount(amount: 5, completion: { (status: Bool, message: String) in
                self.showAlertMessage(status: status, message: message)
            })
        }
        
        //$0,10
        let option10cents = UIAlertAction(title: 10.currencyFormat(), style: .default) { _ in
            Money.shared.addAmount(amount: 10, completion: { (status: Bool, message: String) in
                self.showAlertMessage(status: status, message: message)
            })
        }
        
        //$0,25
        let option25cents = UIAlertAction(title: 25.currencyFormat(), style: .default) { _ in
            Money.shared.addAmount(amount: 25, completion: { (status: Bool, message: String) in
                self.showAlertMessage(status: status, message: message)
            })
        }
        
        optionMenu.addAction(option5cents)
        optionMenu.addAction(option10cents)
        optionMenu.addAction(option25cents)
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    private func showAlertMessage(status: Bool, message: String){
        if status == false {
            let alert = UIAlertController(title: "Ops... :(", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            })
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Life Cycle
    
    static func initFromNib() -> UIView? {
        guard let view = Bundle.main.loadNibNamed("MoneyView", owner: self, options: nil)?.first as? UIView else {
            return UIView()
        }
        return view
    }
    
}
