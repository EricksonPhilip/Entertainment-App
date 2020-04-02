//
//  UIViewController+Extension.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/29/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.tintColor = .white
        let titleView = UIStackView(arrangedSubviews: [titleLbl,imageView])
        titleView.axis = .horizontal
        titleView.spacing = 5

        navigationItem.titleView = titleView
        
        setGestures(label: titleLbl, image: imageView)
    }
    
    func setGestures(label:UILabel,image:UIImageView){
        let gestureReconz =  UITapGestureRecognizer(target: self, action: #selector(tapped))
        gestureReconz.numberOfTouchesRequired = 1
        gestureReconz.numberOfTapsRequired = 1
        label.addGestureRecognizer(gestureReconz)
        image.addGestureRecognizer(gestureReconz)
    }
    
    @objc func tapped(){
        print("Tapped!!!")
    }
}
