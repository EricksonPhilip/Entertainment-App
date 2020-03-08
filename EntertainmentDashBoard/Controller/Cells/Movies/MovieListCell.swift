//
//  MovieListCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/25/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPosture: UIImageView!
    @IBOutlet weak var labelMoviewTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var imgBackDrop: UIImageView!
    
    override func awakeFromNib() {
        imgPosture.layer.cornerRadius = imgPosture.frame.width/2
        imgPosture.clipsToBounds = true
    }
    
    func populate(model:MoviesPostureModel){
        setPostureImageUrl(postureUrl:model.posterPath)
        setBackDropImageUrl(backDropUrl: model.backDropPath)
        labelMoviewTitle.text = model.movieName
        labelGenre.text = "Movie Genres"
    }
    
    private func setPostureImageUrl(postureUrl:String){
        let fullUrl = moviePosterBaseUrl + postureUrl
        let urlPosture = URL(string: fullUrl)
        imgPosture.sd_setImage(with: urlPosture)
        
    }
    
    private func setBackDropImageUrl(backDropUrl:String){
        let fullUrl = movieBackDropBaseUrl + backDropUrl
        let backDropUrl = URL(string: fullUrl)
        //imgBackDrop.sd_setImage(with: backDropUrl)
        imgBackDrop.sd_setImage(with: backDropUrl,
                                placeholderImage: UIImage(named: "MoviePlaceHolder.png"),
                                options:.continueInBackground, completed: nil)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}
