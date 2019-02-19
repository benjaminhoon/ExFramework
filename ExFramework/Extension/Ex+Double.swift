//
//  Ex+Double.swift
//  ExFramework
//
//  Created by 이디야 on 30/01/2019.
//  Copyright © 2019 Hoon. All rights reserved.
//

extension Double
{
    var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        return decimalFormatter.string(from: self as NSNumber) ?? ""
    }
}
