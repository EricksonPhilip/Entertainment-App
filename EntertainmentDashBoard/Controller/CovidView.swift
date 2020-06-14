//
//  CovidView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/9/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

enum covidType{
    case cases
    case recovered
    case deaths
}

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
    
    var type:covidType = .cases
    
    required init(type:covidType,
                  newText:String,
                  totalText:String,
                  headerText:String) {
        super.init(frame: .zero)
        
        setUp()
        self.type = type
        newLabel.text = newText
        totalLabel.text = totalText
        headerLabel.text = headerText
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        switch type {
        case .cases:
            roundCorners(corners: [.topLeft,.bottomLeft], radius: 10)
        case .deaths:
            roundCorners(corners: [.topRight,.bottomRight], radius: 10)
        default:
            print("none")
        }
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
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 12)
    }
}


