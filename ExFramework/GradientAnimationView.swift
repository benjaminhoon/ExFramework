//
//  GradientAnimationView.swift
//  ExFramework
//
//  Created by 이디야 on 14/02/2019.
//  Copyright © 2019 Hoon. All rights reserved.
//

import Foundation


class CradientView {
    var imageBg:UIImageView?    // for example
    var imageLogo:UIImageView?  // for example
    
    var gradientView:UIView!
    
    fileprivate func initGradientView() {
        gradientView = UIView(frame: CGRect(x: -30,
                                            y: 0,
                                            width: 100,
                                            height: 60))
        imageLogo?.addSubview(gradientView)
        gradientView.layer.insertSublayer(gradientColor(frame: gradientView.bounds), at: 0)
        gradientView.backgroundColor = UIColor.clear
    }
    
    fileprivate func gradientColor(frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 0, y: 0.5)
        layer.colors = [UIColor.white.withAlphaComponent(0).cgColor,
                        UIColor.white.withAlphaComponent(0.7).cgColor,
                        UIColor.white.withAlphaComponent(0).cgColor]
        return layer
    }
    
    open func startAnimation() {
        initGradientView()
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: [.autoreverse, .repeat],
                       animations: {
            self.gradientView.frame.origin.x = 100
        }, completion: nil)
    }
    
    open func stopAnimation() {
        gradientView.layer.removeAllAnimations()
        gradientView = nil
    }
}
