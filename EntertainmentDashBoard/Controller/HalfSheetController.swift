//
//  HalfSheetController.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/16/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get{
            guard let theView = containerView else{
                return CGRect.zero
            }
            
            return CGRect(x: 0,
                          y: theView.bounds.height/2 - 100,
                          width: theView.bounds.width,
                          height: theView.bounds.height/2 + 100)
        }
    }
}
