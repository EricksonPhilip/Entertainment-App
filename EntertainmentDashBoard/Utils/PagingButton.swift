//
//  UIButtonWithImage.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/29/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation
import UIKit

class PagingButton: UIButton {
    override var isSelected: Bool{
        didSet{
            if isSelected{
                backgroundColor = .lightGray
            }else{
                backgroundColor = globalColor.cellBackground
            }
        }
    }
}
