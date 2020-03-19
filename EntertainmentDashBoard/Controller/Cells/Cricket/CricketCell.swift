//
//  CricketCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/12/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class CricketCell: UICollectionViewCell {
    
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var loadingIndicator = UIActivityIndicatorView()
    
    private var viewModel:CricketViewModel = CricketViewModel()
    private var indexOfCellBeforeDragging = 0
    private var defaultNumberOfPages = 8
    

    override func awakeFromNib() {
        setDatasourceAndDelegate()
        registerCells()
        setSizingCellsForCollectionView()
        getMatches()
        setLoadingIndicatorInCollectionViews()
        self.pageControl.currentPage = 0
        
    }
    
    func setDatasourceAndDelegate(){
        matchesCollectionView.delegate = self
        matchesCollectionView.dataSource = self
    }
    
    func registerCells(){
        matchesCollectionView.register(UINib(nibName: "MatchesCell",
                                             bundle: nil),
                                       forCellWithReuseIdentifier: "Matches")
    }
    
    func setSizingCellsForCollectionView(){
        if let flowLayout = matchesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = matchesCollectionView {
            let w = collectionView.bounds.size.width - 15
            flowLayout.minimumLineSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: w, height: 300)
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    func setLoadingIndicatorInCollectionViews(){
        loadingIndicator.color = UIColor.white
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
        matchesCollectionView.backgroundView = loadingIndicator
    }
    
    func getMatches(){
        viewModel.getNewMatches(){[weak self] success in
            DispatchQueue.main.async {
                let isLessthan = self!.viewModel.numberOfMatches() < self!.defaultNumberOfPages
                self!.pageControl.numberOfPages = isLessthan ? self!.viewModel.numberOfMatches() : self!.defaultNumberOfPages
                self!.matchesCollectionView.reloadData()
                self?.loadingIndicator.stopAnimating()
                
                if self!.viewModel.numberOfMatches() == 0{
                    self!.loadingIndicator.removeFromSuperview()
                    let infoLabel:UILabel = UILabel()
                    infoLabel.text = "No Matches found !"
                    infoLabel.textColor = UIColor.white
                    infoLabel.textAlignment = .center
                    self!.matchesCollectionView.backgroundView = infoLabel
                    self!.pageControl.numberOfPages = 0
                    self!.pageControl.hidesForSinglePage = true
                }

            }
        }
    }
}



extension CricketCell:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(matchesCollectionView .bounds.size.width - 15 + 10)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(matchesCollectionView!.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)

            newPage = newPage < 0 ? 0 : newPage
            
            newPage = newPage > contentWidth / pageWidth ? ceil(contentWidth / pageWidth) - 1.0 : newPage
        }
        
        self.pageControl.currentPage = Int(newPage) % defaultNumberOfPages
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        print("Current Page :: \(newPage)")
        
    }
}

extension CricketCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMatches()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let matchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Matches", for: indexPath) as! MatchesCell
        let model = viewModel.model[indexPath.row]
        matchCell.populate(model: model)
        return matchCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

extension CricketCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CricketCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 15, height: 50)
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let cellWidth: CGFloat = collectionView.bounds.size.width - 15 // Your cell width
        
        let numberOfCells = floor(self.bounds.size.width / cellWidth)
        let edgeInsets = (self.bounds.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets )
    }
}

extension CricketCell:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}



