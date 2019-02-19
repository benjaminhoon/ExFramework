//
//  Ex+UIApplication.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 11..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension UIApplication{
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    /**
     * 앱스토어와 현재 설치 버전 비교
     * @param
     * @returns Bool
     */
    var isUpgradeAvailable: Bool {
        get{
            let bundleIdentifier = Bundle.main.bundleIdentifier
            let myAppStoreURL = "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier!)&country=kr"
            printFlag("my store URL : \(myAppStoreURL)")
            
            // The URL for this app on the iTunes store uses the Apple ID for the  This never changes, so it is a constant
            guard let appStoreURL = URL(string: myAppStoreURL) else {
                printError("my store address failed convert string to url")
                return false
            }
            
            if let dataInJSON = try? Data(contentsOf: appStoreURL) {
                
                // Try to deserialize the JSON that we got
                if let lookupResults:NSDictionary = try? JSONSerialization.jsonObject(with: dataInJSON, options: JSONSerialization.ReadingOptions()) as! NSDictionary {
                    
                    // Determine how many results we got. There should be exactly one, but will be zero if the URL was wrong
                    if let resultCount = lookupResults["resultCount"] as? Int {
                        if resultCount == 1 {
                            
                            // Get the version number of the version in the App Store
                            if let results:NSArray = lookupResults["results"] as? NSArray {
                                if let appStoreVersion = (results[0] as AnyObject).value(forKey: "version") as? String {
                                    
                                    // Get the version number of the current version
                                    if let currentVersion = Bundle.main.appVersion {
                                        
                                        // Check if they are the same. If not, an upgrade is available.
                                        if appStoreVersion > currentVersion {
                                            return true
                                        }else{
                                            return false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return false
        }
    }
    
}
