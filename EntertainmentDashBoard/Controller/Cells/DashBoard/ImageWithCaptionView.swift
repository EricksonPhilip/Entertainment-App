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
        label.text = "TOp Title"
        label.textColor = .white
        label.backgroundColor = globalColor.commonBGKColor
        label.textAlignment = .center
        label.lineBreakMode  = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.alpha = 0.7
        return label
    }()
    
    lazy var bottomTitle:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bottom Title"
        label.textColor = .white
        label.backgroundColor = globalColor.commonBGKColor
        label.textAlignment = .center
        label.lineBreakMode  = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.alpha = 0.7
        return label
    }()
    
    var topTitleText:String = ""{
        didSet{
            topTitle.text = topTitleText
        }
    }
    
    var bottomTitleText:String = ""{
        didSet{
            bottomTitle.text = bottomTitleText
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
       setImageViewConstraints()
       labelConstraints()
    }
    
    func setImageViewConstraints(){
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func labelConstraints(){
        addSubview(topTitle)
        topTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setImage(strUrl:String){
        let url =  URL(string: strUrl)
        imageView.sd_setImage(with: url)
    }
}
