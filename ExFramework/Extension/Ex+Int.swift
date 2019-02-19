//
//  Ex+Int.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 5..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension Int
{
    var toDouble:Double{
        get{
            return Double(self)
        }
    }
    
    var toFloat:Float{
        get{
            return Float(self)
        }
    }
    
    var toString:String{
        get{
            return String(self)
        }
    }
    
    /**
     * 1: true, etc: false
     * @param
     * @returns Bool
     */
    var toBool:Bool{
        get{
            return self == 1 ? true : false
        }
    }
    
    var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        return decimalFormatter.string(from: self as NSNumber) ?? ""
    }
    
}
