//
//  BaseModelProtocol.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol BaseModelProtocol {
    
    /// Get next key value of the Object on database
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - key: name of the PrimaryKey with reference in database
    /// - Returns: return a next value available to use
    static func getNextId<T: BaseModel>(_ typeObject: T.Type, withKey key: String) -> CLong
    
    /// Save a object represented by JSON
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - content: json object
    /// - Returns: return the object saved
    static func saveObject<T: BaseModel>(_ typeObject: T.Type, fromContent content: [String: Any]) -> T?
    
    /// Save the list of the Objects represented by JSON
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - array: list of json object
    /// - Returns: return the list of the objects saved
    static func saveObjects<T: BaseModel>(_ typeObject: T.Type, fromArray array: [[String: Any]]) -> [T]
    
    /// Get all objects from database represented by type selected
    ///
    /// - Parameter typeObject: Type of the object will use inside the function
    /// - Returns: return a list of the Objects
    static func getObjects<T: BaseModel>(_ typeObject: T.Type) -> [T]?
    
    /// Get objects from database represented by type selected using equal id to compare
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - key: a key that want to compare
    ///   - id: the id of the object that want to find
    /// - Returns: return a list of the Objects
    static func getObjects<T: BaseModel>(_ typeObject: T.Type, withKey key: String, andEqualId id: CLong) -> [T]?
    
    /// Get objects from database represented by type selected using equal value and key to compare
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - key: a key that want to compare
    ///   - value: a value of the key that want to compare
    /// - Returns: return a list of the Objects
    static func getObjects<T: BaseModel>(_ typeObject: T.Type, withKey key: String, andEqualValue value: String) -> [T]?
    
    /// Get objects using a custom filter
    ///
    /// - Parameters:
    ///   - typeObject: Type of the object will use inside the function
    ///   - withFilter: custom filter. e.g.: "id = 1"
    /// - Returns: return a list of the Objects
    static func getObjects<T: BaseModel>(_ typeObject: T.Type, withFilter: String) -> [T]?
    
    /// Update the object in database
    ///
    /// - Parameters:
    ///   - object: Object selected to update
    ///   - value: new object value
    ///   - key: name of the key that want to change the value
    /// - Returns: return a Bool value with status of the transaction
    static func updateObject<T: BaseModel>(object: T, value: Any?, forKey key: String) -> Bool
    
    /// Delete all object of the type selected
    ///
    /// - Parameter typeObject: Type of the object will use inside the function
    /// - Returns: return a Bool value with status of the transaction
    static func deleteObjects<T: BaseModel>(_ typeObject: T.Type) -> Bool
    
    /// Delete the objects selected
    ///
    /// - Parameter objects: List of the objects that will be delete
    /// - Returns: return a Bool value with status of the transaction
    static func deleteObjects<T: BaseModel>(objects: [T]) -> Bool
}
