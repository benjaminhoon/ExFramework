//
//  ExHttpManager.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 15..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol ExHttpResponseDelegate:class {
    func ExHttpResponseJSON(result:Result<Any>, _ url:URLConvertible)
}

public class ExHttpManager {
    
    public typealias Callback = ((_ result: Result<Any>) ->Void)?
    private var callback:Callback

    public weak var delegate:ExHttpResponseDelegate?
    public init() {}
    
    deinit {
        printFlag("--deinit")
    }
}

public extension ExHttpManager{
   
    /**
     * delegate pattern
     * @param
     * @returns JSON
     */
    public func request(url:URLConvertible,
                        method:HTTPMethod = .get,
                        params:Parameters? = nil,
                        encoding:ParameterEncoding = URLEncoding.default) {
        
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                self.delegate?.ExHttpResponseJSON(result: response.result, url)
        }
    }
    
    /**
     * closure pattern
     * @param
     * @returns
     */
    public func request(url:URLConvertible,
                        method:HTTPMethod = .get,
                        params:Parameters? = nil,
                        encoding:ParameterEncoding = URLEncoding.default,
                        completion:Callback) {
        
        self.callback = completion
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                self.callback?(response.result)
        }
    }
    
}


public extension ExHttpManager{
    
    /**
     * 네트워크 활성 여부
     * @param
     * @returns Bool
     */
    func isNetworkAvailable()-> Bool {
        let netManager = NetworkReachabilityManager()
        
        guard let manager = netManager else {
            printError("NetworkReachabilityManager isn't init")
            return false
        }
        
        return manager.isReachable
    }
    
    
}
