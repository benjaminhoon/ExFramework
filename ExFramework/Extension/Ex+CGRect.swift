//
//  Ex+CGRect.swift
//  ExFramework
//
//  Created by LJH on 23/10/2018.
//  Copyright © 2018 Hoon. All rights reserved.
//

import Foundation



public extension CGRect{

    /*   topLeft       topRight
     *      ///////////////
     *      //          //
     *      //////////////
     *   bottmLeft     bottomRight
     */
    
    var topLeft:CGPoint  {
        get{
            return CGPoint(x: minX, y: minY)
        }
    }
    
    var topRight:CGPoint  {
        get{
           return CGPoint(x: maxX, y: minY)
        }
    }
    
    var bottomLeft:CGPoint  {
        get{
            return CGPoint(x: minX, y: maxY)
        }
    }

    var bottomRight:CGPoint  {
        get{
            return CGPoint(x: maxX, y: maxY)
        }
    }
    
}
