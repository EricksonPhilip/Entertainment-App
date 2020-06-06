//
//  UIButton+Extension.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 4/2/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
    func roundedButton(){
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .bottomLeft],
                                    cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
}
