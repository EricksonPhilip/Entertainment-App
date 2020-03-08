//
//  ArtistCollectionCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 3/1/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class ArtistCollectionCell: UICollectionViewCell {

    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var trackCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var viewModel:MusicViewModel = MusicViewModel()
    var trackViewModel:TopTracksViewModel = TopTracksViewModel()
    
    let artistIndicator = UIActivityIndicatorView()
    let tracksIndicator = UIActivityIndicatorView()
    
    var coordinator:MusicCoordinator?
    
    override func awakeFromNib() {
        registerCells()
        setSizingCellsForCollectionView()
        setCollectionView()
        setLoadingIndicatorInCollectionViews()
        getArtistTracks()
        
    }
    
    func setCollectionView(){
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        
        trackCollectionView.delegate = self
        trackCollectionView.dataSource = self
        
        self.pageControl.currentPage = 0
        
    }
    
    func registerCells(){
        artistCollectionView.register(UINib(nibName: "MusicTopArtistCell",
                                           bundle: nil),
                                     forCellWithReuseIdentifier: "TopArtist")
        
        trackCollectionView.register(UINib(nibName: "MusicTopTracksCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "TopTracks")
    }
    
    func setSizingCellsForCollectionView(){
        if let flowLayout = artistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = artistCollectionView {
            let w = 150
            flowLayout.minimumLineSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: w, height: 199)
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
        
        if let trackflowLayout = trackCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let trackCollectionView = trackCollectionView {
            let w = self.bounds.width - 40 
            trackflowLayout.minimumLineSpacing = 10
            trackflowLayout.estimatedItemSize = CGSize(width: w, height: 60)
            trackCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    func setLoadingIndicatorInCollectionViews(){
        artistIndicator.color = UIColor.white
        artistIndicator.hidesWhenStopped = true
        artistIndicator.startAnimating()
        
        tracksIndicator.color = UIColor.white
        tracksIndicator.hidesWhenStopped = true
        tracksIndicator.startAnimating()
        
        artistCollectionView.backgroundView = artistIndicator
        trackCollectionView.backgroundView = tracksIndicator
    }
    
    func getArtistTracks(){
        
        viewModel.getTopArtists(){ [weak self] success in
            if success{
                DispatchQueue.main.async {
                    self!.artistCollectionView.reloadData()
                    self!.artistIndicator.stopAnimating()
                    
                    self?.getTopTracks()
                    
                }
            }
        }

    }
    
    func getTopTracks(){
        trackViewModel.getTopTracks(){ [weak self] success in
            if success{
                DispatchQueue.main.async {
                    self!.trackCollectionView.reloadData()
                    self!.tracksIndicator.stopAnimating()
                }
            }
        }
    }
    
}


extension ArtistCollectionCell:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard  scrollView == trackCollectionView else {
            return
        }
        
        let pageWidth = Float(self.bounds.size.width - 40)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(trackCollectionView!.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        }else{
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            newPage = newPage < 0 ? 0 : newPage
            newPage = newPage > contentWidth / pageWidth ? ceil(contentWidth / pageWidth) - 1.0 : newPage
        }
        
        self.pageControl.currentPage = Int(newPage) %  10
        let point = CGPoint (x: CGFloat(newPage * pageWidth),
                             y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        print("Current Page :: \(newPage)")
        
    }
}

extension ArtistCollectionCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberOfRows = collectionView == artistCollectionView ? viewModel.numberOfArtists() : trackViewModel.numberOfTracks()
        
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == artistCollectionView{
            let topArtistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopArtist",
                                                                   for: indexPath) as! MusicTopArtistCell
            let model =  viewModel.model[indexPath.row]
            topArtistCell.populate(model: model)
            
            return topArtistCell
        }else{
            let topTrackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTracks",
                                                                   for: indexPath) as! MusicTopTracksCell
            let model =  trackViewModel.model[indexPath.row]
            topTrackCell.populate(model: model)
            
            return topTrackCell
        }
        
        
    }
}

extension ArtistCollectionCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator = MusicCoordinator(viewCOntroller: getCurrentController())
        if collectionView == artistCollectionView{
            let model = viewModel.model[indexPath.row]
            coordinator!.showTopMusicsList(url: model.artistUrl,
                                             title: model.artistName)
        }else{
            let model = trackViewModel.model[indexPath.row]
            coordinator!.showTopMusicsList(url: model.trackUrl,
                                           title: model.trackName)
        }
    }
}

extension ArtistCollectionCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView == artistCollectionView ?
            CGSize(width: 190, height: 199) :
            CGSize(width: self.bounds.width - 40 , height: 65)
        
        return size
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5 )
    }
}

extension ArtistCollectionCell{
    func getCurrentController() -> UIViewController{
        
        if let window = self.window,let rootViewController = window.rootViewController {
            var currentController = rootViewController
            while let presentedController = currentController.presentedViewController {
                currentController = presentedController
            }
            return currentController
        }
        
        return UIViewController()
        
    }
}
