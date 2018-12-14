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
    
    private let DB = UserDefaults.standard
}

public extension ExDatabase{
    
    func save<T>(_ value:T, key:String) {
        DB.set(value, forKey: key)
    }
    
    func getBool(key:String) ->Bool{
        return DB.bool(forKey: key)
    }
    
    func getString(key:String) ->String{
        return DB.string(forKey: key) ?? ""
    }
    
    func getInt(key:String) ->Int{
        return DB.integer(forKey:key)
    }
    
    func getDouble(key:String) ->Double{
        return DB.double(forKey:key)
    }
    
    func getObject(key:String) -> Any?{
        return DB.object(forKey: key)
    }
}
