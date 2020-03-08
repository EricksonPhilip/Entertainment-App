//
//  UIView+Extension.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/14/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import Foundation

var associateObjectValue: Int = 0

extension UIView{
    
    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
    func startShimmeringAnimation(){
        self.clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.frame = self.bounds
        self.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1.5
        animation.fromValue = -self.frame.size.width
        animation.toValue = self.frame.size.width
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "")
    }
    
    func stopShimmeringAnimation(){
        self.layer.mask?.removeFromSuperlayer()
        
    }
}


