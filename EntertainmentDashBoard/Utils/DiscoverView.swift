//
//  DiscoverView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/29/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class DiscoverView: UIView {

    lazy var hStackView:UIStackView = {
        let hsView = UIStackView(frame:.zero)
        hsView.translatesAutoresizingMaskIntoConstraints = false
        hsView.axis = .horizontal
        hsView.spacing = 10
        return hsView
    }()
    
    lazy var discoverNameLabel:UILabel = {
        let view = UILabel(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        return view
    }()
    
    lazy var chevDownImgView:UIImageView = {
        let view = UIImageView(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ratingStar")
        return view
    }()
    
    var name:String = ""
    var image:UIImage = UIImage()
    
    required init(frame:CGRect,
                  name:String,
                  image:UIImage) {
        
        super.init(frame:.zero)
        
        self.name = name
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        setStackView()
        addControlsToStackView()
    }
    
    func setStackView(){
        addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addControlsToStackView(){
        hStackView.addArrangedSubview(discoverNameLabel)
        hStackView.addArrangedSubview(chevDownImgView)
        
        chevDownImgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chevDownImgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
