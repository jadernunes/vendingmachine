//
//  Utils.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

class Utils {
    
    /// The alias to represent the closure of the Model
    typealias ProductsCompletion = (([Product]) -> Void)
    
    //Initial data
    let initialData = [
        [
            "idProduct":0,
            "name": "Item 1",
            "price":55,
            "quantity":10,
            "desc":"Lorem Ipsum is simply"
        ],
        [
            "idProduct":1,
            "name": "Item 2",
            "price":70,
            "quantity":10,
            "desc":"Lorem Ipsum is simply dummy text of the printing desc"
        ],
        [
            "idProduct":2,
            "name": "Item 3",
            "price":75,
            "quantity":10,
            "desc":"Lorem Ipsum is simply dummy text of the printing, Lorem Ipsum is simply dummy text of the printing desc"
        ]
        ] as [[String:Any]]
    
    /// Used to load products when the app start
    ///
    /// - Parameter completion: List of Products
    static func initialSetup(completion: @escaping ProductsCompletion) {
        Product.allObjects { (products: [Product]) in
            if products.count == 0 {
                Product.save(array: Utils().initialData, completion: completion)
            } else {
                Product.allObjects(completion: completion)
            }
        }
    }
    
    /// Reset all data in data base and current money
    ///
    /// - Parameter completion: List of Product
    static func resetMachine(completion: @escaping ProductsCompletion) {
        Product.deleteAll { (success: Bool) in
            if success {
                Product.save(array: Utils().initialData, completion: completion)
                Money.shared.setAmount(value: 0)
            } else {
                completion([])
            }
        }
    }
    
    /// Use to migrate the database if needed.
    static func realmMigration() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
        })
    }
}
