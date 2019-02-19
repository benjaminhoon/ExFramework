//
//  DrawPushButton.swift
//  TestApp
//
//  Created by 이디야 on 2018. 10. 19..
//  Copyright © 2018년 JH. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class DrawPushButton: UIButton {
    
    @IBInspectable var isAddButton:Bool = false
    @IBInspectable var fillColor:UIColor = UIColor.blue
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override public func draw(_ rect: CGRect) {
        let path = UIBezierPath (ovalIn : rect)
        fillColor.setFill()
        path.fill ()
        
       
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        
        let plusPath = UIBezierPath()
       
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(
            x: halfWidth - halfPlusWidth,
            y: halfHeight))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + halfPlusWidth,
            y: halfHeight))
        
        if isAddButton{
            plusPath.move(to: CGPoint(
                x: halfWidth,
                y: halfHeight - halfPlusWidth))
            
            plusPath.addLine(to: CGPoint(
                x: halfWidth,
                y: halfHeight + halfPlusWidth))
        }
      
        UIColor.white.setStroke()
        
        plusPath.stroke()
        
    }
}

