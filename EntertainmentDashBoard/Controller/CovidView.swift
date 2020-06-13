//
//  CovidView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/9/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class CovidView: UIView {
   
    lazy var stackView:UIStackView = {
        var sv = UIStackView(frame: .zero)
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var newLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var headerLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(newText:String,
                  totalText:String,
                  headerText:String) {
        super.init(frame: .zero)
        
        setUp()
        
        newLabel.text = newText
        totalLabel.text = totalText
        headerLabel.text = headerText
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(newLabel)
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(headerLabel)
        
        newLabel.backgroundColor = .darkGray
        newLabel.textColor = .black
        newLabel.font = UIFont.systemFont(ofSize: 10)
        newLabel.textAlignment = .right
        newLabel.layer.cornerRadius = 10
        
        totalLabel.textColor = .black
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textColor = .cyan
        
        headerLabel.font = UIFont.systemFont(ofSize: 8)
    }
}
