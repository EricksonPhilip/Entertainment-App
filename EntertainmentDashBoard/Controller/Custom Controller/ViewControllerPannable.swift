//
//  ViewControllerPannable.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/7/19.
//  Copyright © 2019 Eric. All rights reserved.
//
import UIKit
import Foundation

class ViewControllerPannable: UIViewController {
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                      action: #selector(panGestureAction(_:)))

        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        switch panGesture.state{
        case .began:
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
            
        case .changed:
            view.frame.origin = CGPoint(
                x: 0,
                y: translation.y
            )
        case .ended:
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= UIScreen.main.bounds.height/2 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
       
        case .possible,.cancelled,.failed:
            UIView.animate(withDuration: 0.2, animations: {
                self.view.center = self.originalPosition!
            })
        
            
        }
        
        
    }
}
