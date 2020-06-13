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
        sv.spacing = 5
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var newLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var headerLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
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
        
        newLabel.textColor = .black
        newLabel.font = UIFont.systemFont(ofSize: 10)
        newLabel.layer.cornerRadius = 10
        
        totalLabel.textColor = .black
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textColor = .brown
        
        headerLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
