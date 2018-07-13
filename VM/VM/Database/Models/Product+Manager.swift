//
//  Product+Manager.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

extension Product {
    
    func getNextKey(completion: @escaping ((Int) -> Void)) {
        getNextId(Product.self, withKey: "idProduct", withCompletion: completion)
    }
    
    static func save<T: BaseModel>(array: [[String : Any]], completion: @escaping (([T]) -> Void)) {
        saveObjects(T.self, fromArray: array, withCompletion: completion)
    }
    
    static func save<T: BaseModel>(data: [String : Any], completion: @escaping ((T?) -> Void)) {
        saveObject(T.self, fromContent: data, completion: completion)
    }
    
    static func update<T: BaseModel>(object: T,value: Any?, key: String, completion: @escaping ((Bool, T?) -> Void)) {
        updateObject(object: object, value: value, forKey: key, withCompletion: completion)
    }
    
    static func deleteAll(completion: @escaping ((Bool) -> Void)) {
        deleteObjects(Product.self, withCompletion: completion)
    }
    
    static func allObjects<T: BaseModel>(completion: @escaping (([T]) -> Void)) {
        getObjects(T.self, withCompletion: completion)
    }
}
