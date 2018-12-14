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
        if result.isEmpty{
            printError("failed to convert string to JSON")
            return nil
        }
        return result
    }
    
}

/**
 * toData
 * @param JSON, Codable
 * @returns Data
 */
public extension ExJSONParser{
    
    func toData(_ value: String) ->Data?{
        guard let data = Data(base64Encoded: value) else{
            printError("failed to convert string to data")
            return nil
        }
        return data
    }
    
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
                printError("failed to convert JSON to string")
                return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    func toJsonString<O: Codable>(_ value: O) ->String?{
        guard let jsonData = self.toData(value) else {
            printError("failed to convert object to string")
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
}


public extension ExJSONParser{
    
    func toObject<O:Codable>(_ type: O.Type, from: JSON) -> Codable? {
        guard let jsonData = toData(from) else {return nil}
        return toObject(O.self, from: jsonData)
    }
    
    func toObject<O:Codable>(_ type: O.Type, from: Data) -> Codable?{
        do {
            let codable = try jsonDecoder.decode(O.self, from: from)
            return codable
        } catch let error {
            printError(error)
            return nil
        }
    }
    
    func toObject<O:Codable>(_ type: O.Type, from: String) -> Codable?{
        guard let data = toData(from) else {return nil}
        do {
            let codable = try jsonDecoder.decode(O.self, from: data)
            return codable
        } catch let error {
            printError(error)
            return nil
        }
    }
}
