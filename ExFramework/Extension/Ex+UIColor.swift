//
//  Ex+UIColor.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 5..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension UIColor {
    
    convenience init(hex: String) {
        var hexString = hex
        
        if hexString.hasPrefix("#")
        {
           hexString.remove(at: hexString.startIndex)
        }
        
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    var toHexString: String {
        get{
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            
            return String(
                format: "%02X%02X%02X",
                Int(r * 0xff),
                Int(g * 0xff),
                Int(b * 0xff)
            )
        }
    }
    
    
}
