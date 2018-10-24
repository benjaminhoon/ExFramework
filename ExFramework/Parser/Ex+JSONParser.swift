//
//  ExJSONParser.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 16..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
// ex) Object
struct Toy: Codable {
    var name: String
}

struct Employee: Codable {
    var name: String
    var id: Int
    var addrs : Array<Int>
    var favoriteToy: Toy
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case favoriteToy
        case addrs
    }
}
*/


public struct ExJSONParser {
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    public init(){}
}

/**
 * toJSON
 * @param Codable, String
 * @returns JSON
 */
public extension ExJSONParser{
    
    func toJSON<O: Codable>(_ value: O) ->JSON?{
        do {
            let jsonData = try jsonEncoder.encode(value)
            let result = try JSON(data: jsonData)
            return result
        } catch let error {
            printError(error)
            return nil
        }
    }
    
    func toJSON(_ value: String) ->JSON?{
        let result = JSON(parseJSON: value)
        if result.isEmpty{ return nil }
        return result
    }
}

/**
 * toData
 * @param JSON, Codable
 * @returns Data
 */
public extension ExJSONParser{
    
    func toData<O: Codable>(_ value: O) ->Data?{
        do {
            let jsonData = try jsonEncoder.encode(value)
            return jsonData
            
        } catch let error {
            printError(error)
            return nil
        }
    }
 
    func toData(_ value: JSON) ->Data?{
        do {
            let jsonData = try value.rawData(options: .prettyPrinted)
            return jsonData
            
        } catch let error {
            printError(error)
            return nil
        }
    }
}

/**
 * toJsonString
 * @param Data, JSON, Codable
 * @returns String
 */
public extension ExJSONParser{
    
    func toJsonString(_ value: Data) ->String?{
        return String(data: value, encoding: .utf8)
    }
   
    func toJsonString(_ value: JSON) ->String?{
        guard let json = self.toJSON(value),
            let jsonData = self.toData(json) else {
                printError()
                return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    func toJsonString<O: Codable>(_ value: O) ->String?{
        guard let jsonData = self.toData(value) else {
            printError()
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
}


public extension ExJSONParser{
    
    func toObject<T:Codable>(_ type: T.Type, from: Data) -> Codable?{
        do {
            let codable = try jsonDecoder.decode(T.self, from: from)
            return codable
        } catch let error {
            printError(error)
            return nil
        }
    }
}
