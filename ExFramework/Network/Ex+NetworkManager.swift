//
//  ExNetworkManager.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 15..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation
import Alamofire

public protocol ExNetworkResponseDelegate:class {
    func exHttpResponseJSON(response jsonString:String, request url:URLConvertible)
}

public class ExNetworkManager {
    
    private var callback:Callback
    private var sessionManager:SessionManager {
        get{
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest  = 30
            return Alamofire.SessionManager(configuration: config )
        }
    }
    
    
    public typealias Callback = ((_ result:String, _ url:URLConvertible) ->Void)?
    public weak var delegate:ExNetworkResponseDelegate?
  
    
    public init() {
    }
    
    deinit {
        printFlag("--deinit")
    }
}

public extension ExNetworkManager{
   
    /**
     * delegate pattern
     * @param
     * @returns JSON
     */
    public func request(url:URLConvertible,
                        method:HTTPMethod = .get,
                        params:Parameters? = nil,
                        encoding:ParameterEncoding = URLEncoding.default) {
        
        self.sessionManager.request(url,
                                    method: method,
                                    parameters: params,
                                    encoding: encoding,
                                    headers: nil)
            .responseJSON { (response) in
                
                switch response.result{
                case .success(let data):
                    let resultJSON = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                    self.delegate?.exHttpResponseJSON(response: String(data: resultJSON, encoding: String.Encoding.utf8)!, request: url)
                    break
                case .failure(let error):
                    printError(error.localizedDescription)
                    break
                    
                }
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
        self.sessionManager.request(url,
                                    method: method,
                                    parameters: params,
                                    encoding: encoding,
                                    headers: nil)
            .responseJSON { (response) in
                
                switch response.result{
                case .success(let data):
                    let resultJSON = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                    self.callback?(String(data: resultJSON, encoding: String.Encoding.utf8)!, url)
                    break
                case .failure(let error):
                    printError(error.localizedDescription)
                    break
                    
                }
                
        }
       
    }
    
}


public extension ExNetworkManager{
    
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
