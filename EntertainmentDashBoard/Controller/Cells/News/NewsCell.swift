//
//  NewsCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var newsCollectionView: UICollectionView!
    var loadingNewIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var viewModel:NewsViewModel = NewsViewModel()

    
    override func awakeFromNib() {
        self.startShimmeringAnimation()
        getTopHeadLines()
        setSizingCellsForCollectionView()
        registerCells()
        setCollectionView()
    }
    
    func registerCells(){
        newsCollectionView.register(UINib(nibName: "NewsListCell", bundle: nil),
                                    forCellWithReuseIdentifier: "NewsList")
    }
    
    func setSizingCellsForCollectionView(){
        if let flowLayout = newsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = newsCollectionView {
            
            let w = 250
            flowLayout.minimumLineSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: w,
                                                  height: 232)
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    func setCollectionView(){
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }

    func getTopHeadLines(){
        viewModel.getTopHeadLines(){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.stopShimmeringAnimation()
                    self?.newsCollectionView.reloadData()
                }
            }
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



extension NewsCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let NewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsList",
                                                         for: indexPath) as! NewsListCell
        let model = viewModel.model[indexPath.row]
        NewCell.populate(model: model)
        return NewCell
    }
}

extension NewsCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = viewModel.model[indexPath.row]
        
        let storyboard = UIStoryboard(name: "EntertainmentBoard", bundle: nil)
        let NewsSource = storyboard.instantiateViewController(withIdentifier: "NewsSource") as! SourceWebViewController
        
        NewsSource.urlString = model.newsUrl
        NewsSource.sourceTitle = model.sourceName
     
        if let window = self.window, let rootViewController = window.rootViewController {
            var currentController = rootViewController
            while let presentedController = currentController.presentedViewController {
                currentController = presentedController
            }
            currentController.present(NewsSource, animated: true, completion: nil)
        }
    }
}

extension NewsCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:250 , height: 250)//collectionView.bounds.size.width - 15
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5 )
    }
}
extension NewsCell:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
