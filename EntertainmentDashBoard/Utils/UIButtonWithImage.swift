//
//  UIButtonWithImage.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/29/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation
import UIKit

class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width-40), bottom:5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}
