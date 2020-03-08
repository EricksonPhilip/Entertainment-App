//
//  MovieHeaderView.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MovieHeaderView: UICollectionReusableView {
    @IBOutlet weak var imgBackDrop: UIImageView!
    @IBOutlet weak var imgPosture: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        setShadowOnView()
    }
    
    func populate(postureUrl:String,
                  name:String,
                  backDropUrl:String){
        
        let fullUrl = moviePosterBaseUrl + postureUrl
        let backDropURL = movieBackDropBaseUrl + backDropUrl
        let _url = URL(string: fullUrl)
        let _backDropUrl = URL(string: backDropURL)
        
        imgPosture.sd_setImage(with: _url,
                               placeholderImage: defaultMovieImage,
                               options: .continueInBackground)
        
        imgBackDrop.sd_setImage(with: _backDropUrl,
                                placeholderImage: defaultMovieImage,
                                options: .delayPlaceholder)
        
        movieNameLabel.text = name
    }
    
    func setShadowOnView(){
        imgPosture.layer.shadowColor = UIColor.black.cgColor
        imgPosture.layer.shadowOpacity = 1
        imgPosture.layer.shadowOffset = CGSize.zero
        imgPosture.layer.shadowRadius = 10
        imgPosture.layer.shadowPath = UIBezierPath(rect: imgPosture.bounds).cgPath
        imgPosture.layer.shouldRasterize = true
        
        movieNameLabel.layer.shadowColor = UIColor.white.cgColor
        movieNameLabel.layer.shadowOpacity = 1
        movieNameLabel.layer.shadowOffset = CGSize.zero
        movieNameLabel.layer.shadowRadius = 25
        movieNameLabel.layer.shadowPath = UIBezierPath(rect: movieNameLabel.bounds).cgPath
        movieNameLabel.layer.shouldRasterize = true
    }
    
}
