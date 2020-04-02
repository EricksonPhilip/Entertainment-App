//
//  MovieDetailsCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MovieDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var overViewHeaderLabel: UILabel!
    @IBOutlet weak var overViewContentLabel: UILabel!
    override func awakeFromNib() {
        backgroundColor = globalColor.commonBGKColor
    }
    
    func populate(overView:String){
        overViewContentLabel.text = overView
        overViewContentLabel.sizeToFit()
        
        overViewHeaderLabel.layer.addBorder(edge: .bottom,
                                            color:UIColor.white ,
                                            thickness: 0.3)
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
