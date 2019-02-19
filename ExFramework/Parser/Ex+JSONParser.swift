//
//  ExJSONParser.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 16..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation

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
    public init(){
        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        } else {
            jsonEncoder.outputFormatting = .prettyPrinted
        }
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
    
    func toJsonString<O: Codable>(_ value: O) ->String?{
        guard let jsonData = self.toData(value) else {
            printError("failed to convert object to string")
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
}


public extension ExJSONParser{
    
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
        guard let data = toData(from) else { return nil }
        do {
            let codable = try jsonDecoder.decode(O.self, from: data)
            return codable
        } catch let error {
            printError(error)
            return nil
        }
    }
}
