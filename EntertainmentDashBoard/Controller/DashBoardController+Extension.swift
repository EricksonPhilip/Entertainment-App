//
//  DashBoardController+Extension.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

extension DashBoardController:UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberOfItems =  1
    
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: "MainSection",
                                                                               for: indexPath) as? MainSectionHeaderView{
            
            let model = modelArray[indexPath.section]
            switch model {
            case .cricket:
                sectionHeader.sectionheaderLabel.text = "Cricket"
            case .movies:
                sectionHeader.sectionheaderLabel.text = "Movies"
            case .tv:
                sectionHeader.sectionheaderLabel.text = "Popular TV Shows"
            case .weather:
                sectionHeader.sectionheaderLabel.text = "Weather"
            case .news:
                sectionHeader.sectionheaderLabel.text = "News"
            case .music:
                sectionHeader.sectionheaderLabel.text = "Music"
            }
        
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = modelArray[indexPath.section]
        
        switch model {
        case .weather:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "weather",
                                                           for: indexPath) as! WeatherCell
            
            if let weatherModel = weatherViewModel.model {
                cells.populate(model: weatherModel)
            }
            return cells
        case .cricket:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "cricket",
                                                           for: indexPath) as! CricketCell
            return cells
        case .movies:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "movies",
                                                           for: indexPath) as! MovieCell
            return cells
        case .tv:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "TV",
                                                           for: indexPath) as! TvCell
            return cells
        case .news:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "news",
                                                           for: indexPath) as! NewsCell
            return cells
       
        case .music:
            let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell",
                                                           for: indexPath) as! ArtistCollectionCell
            return cells
        }
        
        
    }

}



extension DashBoardController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //route?.openMusicTopArtists(for: MusicArtistsModel(musicId: "", artistName: "Erick", artistUrl: "Https://", imageUrl: ""))
    }
}

extension DashBoardController:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
         return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension DashBoardController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let sectionHeight:CGFloat = 60
        return CGSize(width: self.view.bounds.width, height: sectionHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var itemHeight:CGFloat = 0
        let itemWidth:CGFloat = self.view.bounds.width
        
        switch modelArray[indexPath.section]{
        case .movies:
            itemHeight = 400
        case .cricket:
            itemHeight = 300
        case .tv:
            itemHeight = 230
        case .weather:
            itemHeight = 106
        case .news:
            itemHeight = 250
        case .music:
            itemHeight = 670
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let insets:CGFloat = section == 2 ? 20 : 0
        
        return UIEdgeInsets(top: 0, left: insets, bottom: 0, right: insets )
    }
}
