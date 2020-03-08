//
//  MusicCoordinator.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/18/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

class MusicCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var viewController: UIViewController //UINavigationController
    
    init(viewCOntroller: UIViewController) {
        self.viewController = viewCOntroller
    }
    
    func showTopMusicsList(url:String,title:String) {
        let topMusicWebViewController = SourceWebViewController.instantiate()
        topMusicWebViewController.urlString = url
        topMusicWebViewController.sourceTitle = title
        topMusicWebViewController.coordinator = self
        viewController.present(topMusicWebViewController, animated: false, completion: nil)
        
    }
    
}
