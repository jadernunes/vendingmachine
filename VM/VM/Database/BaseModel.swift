//
//  BaseModel.swift
//  VM
//
//  Created by Jader Nunes on 2018-07-11.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

let threadDefault = DispatchQueue.main

/// If there are more objects, this way is easy to use base attributes
class BaseModel: Object {
    
    func getNextId<T: BaseModel>(_ typeObject: T.Type, withKey key: String, withCompletion completion:@escaping ((CLong) -> Void)) {
        threadDefault.async {
            do {
                let realm = try Realm()
                realm.refresh()
                
                if realm.objects(T.self).count > 0  {
                    let id = realm.objects(T.self).max(ofProperty: key)! + 1
                    completion(id)
                } else {
                    completion(1)
                }
            } catch let err {
                print("Error while getting last id '\(T.self.description())' from realm: \(err)")
                completion(0)
            }
        }
    }
}

//MARK: - Save objects

func saveObject<T: BaseModel>(_ typeObject: T.Type, fromContent content: [String: Any], completion:@escaping ((T?) -> Void)) {
    threadDefault.async {
        var object: T?
        do {
            let realm = try Realm()
            try realm.write {
                object = realm.create(T.self, value: content, update: true)
            }
        } catch let err {
            print("Error while writing '\(T.self.description())' to realm: \(err)")
            completion(nil)
        }
        
        completion(object)
    }
}

func saveObjects<T: BaseModel>(_ typeObject: T.Type, fromArray array: [[String: Any]],  withCompletion completion:@escaping (([T]) -> Void)) {
    threadDefault.async {
        var objects: [T] = []
        
        for item in array {
            do {
                let realm = try Realm()
                realm.beginWrite()
                
                let object: T = realm.create(T.self, value: item, update: true)
                objects.append(object)
                
                try realm.commitWrite()
            } catch let err {
                print("Error while writing '\(T.self.description())' to realm: \(err)")
            }
        }
        
        completion(objects)
    }
}

//MARK: - Get objects

func getObjects<T: BaseModel>(_ typeObject: T.Type, withCompletion completion:@escaping (([T]) -> Void)) {
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            let listObjects: [T] = realm.objects(T.self).map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting all '\(T.self.description())' from realm: \(err)")
            completion([])
        }
    }
}

func getObjects<T: BaseModel>(_ typeObject: T.Type, withKey key: String, andEqualId id: CLong, withCompletion completion:@escaping (([T]) -> Void)){
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            let listObjects: [T] = realm.objects(T.self).filter("\(key) = \(id)").map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting '\(T.self.description())' by \(key) '\(id)' from realm: \(err)")
            completion([])
        }
    }
}

func getObjects<T: BaseModel>(_ typeObject: T.Type, withKey key: String, andEqualValue value: String, withCompletion completion:@escaping (([T]) -> Void)) {
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            let listObjects: [T] = realm.objects(T.self).filter("\(key) = '\(value)'").map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting '\(typeObject.description())' by \(key) '\(value)' from realm: \(err)")
            completion([])
        }
    }
}

func getObjects<T: BaseModel>(_ typeObject: T.Type, withFilter: String, withCompletion completion:@escaping (([T]) -> Void)) {
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            let listObjects: [T] = realm.objects(T.self).filter(withFilter).map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting '\(T.self.description())' by \(withFilter)' from realm: \(err)")
            completion([])
        }
    }
}

//MARK: - Update objects

func updateObject<T: BaseModel>(object: T, value: Any?, forKey key: String,  withCompletion completion:@escaping ((Bool, T?) -> Void)) {
    threadDefault.async {
        do {
            let realm = try Realm()
            try realm.write {
                object.setValue(value, forKey: key)
            }
        } catch let err {
            print("Error while updating \(T.self.debugDescription) key '\(key)' with value '\(value.debugDescription)' to realm: \(err.localizedDescription)")
            completion(false, nil)
        }
        
        completion(true, object)
    }
}

//MARK: - Delete objects

func deleteObjects<T: BaseModel>(_ typeObject: T.Type, withCompletion completion:@escaping ((Bool) -> Void)){
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            let objects = realm.objects(T.self)
            try realm.write {
                realm.delete(objects)
            }
        } catch let err {
            print("Error while removing all '\(T.self.description())' from realm: \(err)")
            completion(false)
        }
        
        completion(true)
    }
}

func deleteObjects<T: BaseModel>(objects: [T], withCompletion completion:@escaping ((Bool) -> Void)) {
    threadDefault.async {
        do {
            let realm = try Realm()
            realm.refresh()
            try realm.write {
                realm.delete(objects)
            }
        } catch let err {
            print("Error while removing all '\(T.self.description())' from realm: \(err)")
            completion(false)
        }
        
        completion(true)
    }
}
