//
//  ExNetworkManager.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 15..
//  Copyright © 2018년 Hoon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol ExNetworkResponseDelegate:class {
    func exHttpResponseJSON(response result:JSON, request url:URLConvertible)
}

public class ExNetworkManager {
    
    private var callback:Callback
    private var sessionManager:SessionManager
    
    public typealias Callback = ((_ result: Result<Any>) ->Void)?
    public weak var delegate:ExNetworkResponseDelegate?
    public init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest  = 30
        self.sessionManager = Alamofire.SessionManager(configuration: config )
        
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
                    let resultJSON = JSON(data: data as! Data)
                    self.delegate?.exHttpResponseJSON(response: resultJSON, request: url)
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
