//
//  Ex+Bundle.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 5..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension Bundle {
    
    var appName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
    
    var appVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersion: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    

}
