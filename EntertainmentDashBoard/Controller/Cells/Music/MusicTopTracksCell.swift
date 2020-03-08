//
//  MusicTopTracksCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 3/4/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MusicTopTracksCell: UICollectionViewCell {
    
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var imgTrack: UIImageView!
    
    override func awakeFromNib() {
        setCornerRadius()
        setShadowDrop()
    }
    
    func setCornerRadius(){
        imgTrack.layer.addBorder(edge: [.left,.right],
                             color: UIColor.red,
                             thickness: 5)
        imgTrack.layer.borderColor = UIColor.red.cgColor
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.imgTrack.layer.cornerRadius = 5
        self.imgTrack.clipsToBounds = true
        
        self.backgroundColor = globalColor.cellBackground
    }
    
    func setShadowDrop(){
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(0.2),
                                         height: CGFloat(0.2))
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func populate(model:MusicTopTracksModel){
        trackNameLabel.text = model.trackName
        artistNameLabel.text = model.artist.artistName
        setImage(imageUrl: model.trackImageUrl)
        
    }
    
    func setImage(imageUrl:String){
        let urlTrack = URL(string: imageUrl)
        imgTrack.sd_setImage(with: urlTrack)
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
