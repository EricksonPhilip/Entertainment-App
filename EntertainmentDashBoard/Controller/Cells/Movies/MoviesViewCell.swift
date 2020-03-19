//
//  MoviesViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/15/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class MoviesViewCell: UICollectionViewCell {
    
    static var movieCellID = "MoviesCell"
    
    lazy var imgView:UIImageView = {
        let vView = UIImageView(frame:.zero)
        vView.translatesAutoresizingMaskIntoConstraints = false
        return vView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(){
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
    }
    
    func populate(model:MoviesPostureModel){
        let fullUrl = moviePosterBaseUrl + model.posterPath
        let urlPosture = URL(string: fullUrl)
        imgView.sd_setImage(with: urlPosture)
    }

}
