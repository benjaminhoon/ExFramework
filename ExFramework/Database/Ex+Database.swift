//
//  ExDatabase.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 17..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation

public struct ExDatabase{
    static let shared = ExDatabase()
    private init(){}
    
    private let userDefaults = UserDefaults.standard
}

public extension ExDatabase{
    
    func save<T>(_ value:T, key:String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getBool(key:String) ->Bool{
        return userDefaults.bool(forKey: key)
    }
    
    func getString(key:String) ->String{
        return userDefaults.string(forKey: key) ?? "unknown"
    }
    
    func getInt(key:String) ->Int{
        return userDefaults.integer(forKey:key)
    }
    
    func getDouble(key:String) ->Double{
        return userDefaults.double(forKey:key)
    }
    
    func getObject(key:String) -> Any?{
        return userDefaults.object(forKey: key)
    }
}
