//
//  NewsListCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/6/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import SDWebImage

class NewsListCell: UICollectionViewCell {
    
    @IBOutlet weak var imgNewsSource: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
       self.layer.cornerRadius = 5
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.backgroundColor = globalColor.cellBackground
    
    }
    
    public func populate(model:NewsModel){
        setImageUrl(imageUrl: model.newsImageUrl!)
        self.titleLabel.text = model.newsTitle
    }
    
    private func setImageUrl(imageUrl:String){
        let url = URL(string: imageUrl)
        imgNewsSource.sd_setImage(with: url)
    }
    
    func setClearForLabels(label:UILabel){
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0.5
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0,
                                          height: -0.5)
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
