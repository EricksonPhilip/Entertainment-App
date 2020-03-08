//
//  UIAlertViewController+Extension.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/14/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
    func setBackground(textColor:UIColor,background:UIColor){
        let subview = (self.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = background
        
        self.view.tintColor = textColor
    }
}

extension UIAlertAction{
    func setImage(image:UIImage){
        self.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")
    }
}
