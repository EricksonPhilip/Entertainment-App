//
//  HeaderDashBoardView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/9/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class HeaderDashBoardView: UICollectionReusableView {
    
    static let resuableViewID = "headerID"
    lazy var headerTitle:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 30)
        return view
    }()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "icons8-user-male")
        view.tintColor = .white
        return view
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(headerTitle)
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        headerTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        headerTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        imageView.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor).isActive = true
    }
}
