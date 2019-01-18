//
//  Ex+Util.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 15..
//  Copyright © 2018년 Hoon. All rights reserved.
//
import Foundation

/*
 * global APP Life Cycle
 *
func sampleNotificationCenter()
{
    NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: .UIApplicationWillTerminate, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(appEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
}


func appWillEnterForeground()
{

}

func appWillTerminate()
{

}

func appDidBecomeActive()
{

}

func appEnterBackground()
{

}
*/

/**
 * after UI Thread
 */
func after(delay:TimeInterval, completion:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        completion()
    }
}

/**
 * 디버깅
 */
var DEBUG = true
public func printError(_ items: Any..., separator: String = ",", file:String = #file, line:Int = #line, function: String = #function) {
    if DEBUG
    {
        print("❌ \(file.components(separatedBy: "/").last!), line: \(line) | func \(function) \n\(items.map{ String(describing: $0) }.joined(separator: separator))\n")
    }
}
public func printOK(_ items: Any..., separator: String = ",", file:String = #file, line:Int = #line, function: String = #function) {
    if DEBUG
    {
        print("✅ \(file.components(separatedBy: "/").last!), line: \(line) | func \(function) \n\(items.map{ String(describing: $0) }.joined(separator: separator))\n")
    }
}
public func printFlag(_ items: Any..., separator: String = ",", file:String = #file, line:Int = #line, function: String = #function) {
    if DEBUG
    {
        print("🚩 \(file.components(separatedBy: "/").last!), line: \(line) | func \(function) \n\(items.map{ String(describing: $0) }.joined(separator: separator))\n")
    }
}
