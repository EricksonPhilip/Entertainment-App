//
//  MusicTopArtistCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 3/1/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MusicTopArtistCell: UICollectionViewCell {
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var labelArtistName: UILabel!
    
    override func awakeFromNib() {
        self.imgArtist.layer.cornerRadius = 5
        self.imgArtist.clipsToBounds = true
        
        applyBorder()
    }
    
    func applyBorder(){
        self.imgArtist.layer.borderColor = UIColor.white.cgColor
        self.imgArtist.layer.borderWidth = 0.5
    }
    
    func populate(model:MusicArtistsModel){
        setImageUrl(url: model.imageUrl)
        labelArtistName.text = model.artistName
    }
    
    func setImageUrl(url:String){
        let urlArtist = URL(string: url)
        imgArtist.sd_setImage(with: urlArtist)
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
