//
//  TvPopularCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/8/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import SDWebImage

class TvPopularCell: UICollectionViewCell {
    
    @IBOutlet weak var imgTvShows: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    
    private var artworkImageShrinkFinishDate: Date?
    private static let artworkScaleFactor: CGFloat = 0.95
    private static let artworkFadeFactor: CGFloat = 0.95
    private static let activationStateAnimationDuration: TimeInterval = 0.1
    
    override func awakeFromNib() {
        setShadowDrop()
    }
    
    func populate(model:PopularTVModel){
        setImageView(imgUrl: model.backDropPath)
        showNameLabel.text = model.name
    }
    
    func setImageView(imgUrl:String){
        let fullUrl = moviePosterBaseUrl + imgUrl
        let _url = URL(string: fullUrl)
        
        imgTvShows.sd_setImage(with: _url,
                                     placeholderImage: defaultTVImage,
                                     options: .continueInBackground)
        
    }
    
    func setShadowDrop(){
        let shadowPath2 = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(0.3), height: CGFloat(0.3))
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath2.cgPath
    }
    
    public func animateArtworkImage(isHighlighted: Bool) {
        if isHighlighted {
            artworkImageShrinkFinishDate = Date(timeIntervalSinceNow: TvPopularCell.activationStateAnimationDuration)
            UIView.animate(withDuration: TvPopularCell.activationStateAnimationDuration) { [weak self] in
                
                let transform = CGAffineTransform(
                    scaleX: TvPopularCell.artworkScaleFactor,
                    y: TvPopularCell.artworkScaleFactor)
                self?.transform = transform
                self?.alpha = TvPopularCell.artworkFadeFactor
                self?.transform = transform
            }
        } else {
            let delay: TimeInterval
            if let artworkImageShrinkFinishDate = artworkImageShrinkFinishDate {
                let interval = artworkImageShrinkFinishDate.timeIntervalSinceNow
                delay = interval < TvPopularCell.activationStateAnimationDuration ? interval : 0
            }else{
                delay = 0
            }
            artworkImageShrinkFinishDate = nil
            UIView.animate(
                withDuration: TvPopularCell.activationStateAnimationDuration,
                delay: delay,
                options: .curveLinear,
                animations: { [weak self] in
                    self?.transform = .identity
                    self?.alpha = 1
                    self?.transform = .identity
                },
                completion: nil)
        }
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
