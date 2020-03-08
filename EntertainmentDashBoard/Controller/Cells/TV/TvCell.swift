//
//  TvCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class TvCell: UICollectionViewCell {
    
    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    var viewModel:PopularTvViewModel = PopularTvViewModel()
    
    override func awakeFromNib() {
        registerCells()
        setSizingCellsForCollectionView()
        getPoppularTvShows()
        setCollectionView()
    }
    
    func registerCells(){
        tvCollectionView.register(UINib(nibName: "PopularTVCell", bundle: nil),
                                    forCellWithReuseIdentifier: "TvPopular")
    }
    
    func setSizingCellsForCollectionView(){
        if let flowLayout = tvCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = tvCollectionView {
            
            let w = 300
            flowLayout.minimumLineSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: w, height: 200)
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    func setCollectionView(){
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
    }
    
    func getPoppularTvShows(){
        viewModel.getPopularTvShows(){[weak self]
             success in
            DispatchQueue.main.async {
                if success{
                    self!.tvCollectionView.reloadData()
                }
            }
            
        }
    }
}

extension TvCell:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = tvCollectionView.contentOffset
        visibleRect.size = tvCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = tvCollectionView.indexPathForItem(at: visiblePoint) else { return }
        
        let visibleCell = tvCollectionView.cellForItem(at: indexPath) as! TvPopularCell
        
        visibleCell.animateArtworkImage(isHighlighted: false)
    }
}

extension TvCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfTvShows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let popularTvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvPopular",
                                                         for: indexPath) as! TvPopularCell
        let model = viewModel.model[indexPath.row]
        popularTvCell.populate(model: model)
        popularTvCell.animateArtworkImage(isHighlighted: true)
        return popularTvCell
    }
}

extension TvCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension TvCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:300, height: 200)
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10 )
    }
}
