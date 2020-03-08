//
//  MusicRoute.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/18/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var viewController: UIViewController { get set }
    
    func showTopMusicsList(url:String,title:String)
}


