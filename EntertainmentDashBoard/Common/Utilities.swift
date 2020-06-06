//
//  Global.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/12/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

class utilities {
    
    func kelvinToFahrenheit(value:Float) -> Float{
        
        let fVal = (value - 273.15) * 9/5 + 32
        return fVal
    }
    
    func FahrenheitToCelcius(value:Float) -> Float{
        
        let cVal = (value - 32) * 5/9
        return cVal
    }
    
    func CelciusToFahreheit(value:Float) -> Float{
        
        let fVal = (value * 9/5) + 32
        return fVal
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


