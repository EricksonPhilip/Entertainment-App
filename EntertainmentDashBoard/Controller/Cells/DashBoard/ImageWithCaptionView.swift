//
//  ImageWithCaptionView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 4/11/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class ImageWithCaptionView: UIView {
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var topTitle:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = globalColor.commonBGKColor
        label.textAlignment = .center
        label.lineBreakMode  = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
        
    lazy var stackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    var topTitleText:String = ""{
        didSet{
            topTitle.text = topTitleText
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
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
        
        stackView.addArrangedSubview(topTitle)
        stackView.addArrangedSubview(imageView)
        
        let topTitleConst = topTitle.heightAnchor.constraint(equalToConstant: -100)
        topTitleConst.priority = UILayoutPriority.init(rawValue: 999)
        topTitleConst.isActive = true
        
    }
    
    func setImage(strUrl:String){
        let url =  URL(string: strUrl)
        imageView.sd_setImage(with: url, completed: {
            (image, error, cacheType, url) in
            if image == nil{
                self.topTitle.lineBreakMode = .byWordWrapping
                self.topTitle.numberOfLines = .zero
                self.topTitle.textAlignment = .justified
            }
        })
       
    }
}
