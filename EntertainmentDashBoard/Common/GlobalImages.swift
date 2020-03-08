//
//  GlobalImages.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/19/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

public var defaultMovieImage:UIImage{
    return UIImage(named: "defaultMovieImage", in: nil, compatibleWith: nil)!
}

public var defaultTVImage:UIImage{
    return UIImage(named: "DefaultTVImage64", in: nil, compatibleWith: nil)!
}

public var loadinImage:UIImage{
    return UIImage(named: "Loading", in: nil, compatibleWith: nil)!
}

public var thickDownArrowImage:UIImage{
    return UIImage(named: "DownArrow-1", in: nil, compatibleWith: nil)!
}

struct globalColor {
    public static var alertControllerBackground = UIColor(red: (60/255.0),
                                                          green: (60/255.0),
                                                          blue: (60/255.0),
                                                          alpha: 1.0)
    public static var cellBackground = UIColor(red: (32/255.0),
                                               green: (32/255.0),
                                               blue: (32/255.0),
                                               alpha: 1.0)
}

