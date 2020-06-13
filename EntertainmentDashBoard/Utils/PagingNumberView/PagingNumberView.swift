//
//  PagingNumberView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 4/1/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class PagingNumberView: UIView {
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    lazy var hStackView:UIStackView = {
        let sView = UIStackView(frame: .zero)
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .horizontal
        sView.spacing = 5
        sView.distribution = .equalSpacing
        return sView
    }()
    
    lazy var numberView:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var numberArray:[String] = [String](){
        didSet{
            addLabelsToStackView()
        }
    }
    
    var paginButtonArray:[PagingButton] = [PagingButton]()
    
    public var pageTapAction:((Int)->Void)?
    
    required init() {
        super.init(frame:.zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        setScrollViewConstrainst()
        setStackViewConstrainst()
        addLabelsToStackView()
    }
    
    func setScrollViewConstrainst(){
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setStackViewConstrainst(){
        scrollView.addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 5).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -5).isActive = true
    }
    
    func addLabelsToStackView(){
        
        guard  numberArray.count > 0 else {
            return
        }
        
        for i in 0...numberArray.count-1{
            let numberLabel = PagingButton()
            numberLabel.setTitle(numberArray[i], for: .normal)
            numberLabel.addTarget(self, action: #selector(numberTapped), for: .touchUpInside)
            numberLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true
            numberLabel.widthAnchor.constraint(equalToConstant: 38).isActive = true
            numberLabel.tag = i
            styleNumberLabel(numberLabel)
            hStackView.addArrangedSubview(numberLabel)
            
            paginButtonArray.append(numberLabel)
        }
    }
    
    func styleNumberLabel(_ label:UIButton){
        label.backgroundColor = globalColor.cellBackground
        label.layer.cornerRadius = 38/2
    }
    
    @objc func numberTapped(_ sender:UIButton){
        if let tapAction = pageTapAction{
            
            paginButtonArray.forEach { $0.isSelected = false
                $0.backgroundColor = globalColor.cellBackground
            }

            paginButtonArray[sender.tag].backgroundColor = .lightGray
            paginButtonArray[sender.tag].isSelected = true
            
    
            tapAction(sender.tag+1)
        }
    }
}
