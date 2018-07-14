//
//  CustomModelProtocol.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol CustomModelProtocol {
    
    /// Get next key value of the Object on database
    ///
    /// - Parameter completion: represent the closure
    /// - Returns: return the new value of the key(PrimaryKey)
    func getNextKey(completion: @escaping ((Int) -> Void))
    
    /// Save the list of the Objects represented by JSON
    ///
    /// - Parameters:
    ///   - array: array of JSON
    ///   - completion: represent the closure
    /// - Returns: return a list of the Objects saved
    static func save<T: BaseModel>(array: [[String: Any]], completion: @escaping (([T]) -> Void))
    
    /// Save a object represented by JSON
    ///
    /// - Parameters:
    ///   - data: JSON of the Object
    ///   - completion: represent the closure
    /// - Returns: return the object saved
    static func save<T: BaseModel>(data: [String: Any], completion: @escaping ((T?) -> Void))
    
    /// Delete all objects on database
    ///
    /// - Parameter completion: represent the closure
    /// - Returns: return a Boolean status of the transaction
    static func deleteAll(completion: @escaping ((Bool) -> Void))
    
    /// Getl all objects on database
    ///
    /// - Parameter completion: represent the closure that return a list of the objects
    static func allObjects<T: BaseModel>(completion: @escaping (([T]) -> Void))
}
