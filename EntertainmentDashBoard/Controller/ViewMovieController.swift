//
//  ViewCricketScoreController.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/16/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class ViewMovieController: ViewControllerPannable {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    public var postureURL:String!
    public var movieName:String!
    public var movieOverView:String!
    public var backDropUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = detailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        layout?.sectionHeadersPinToVisibleBounds = true
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        
        registerCollectionCells()
        setNavLayout()
        setStyleCloseButton()
    }
    
    func setNavLayout(){
        navigationView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
    }
    
    func setStyleCloseButton(){
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        closeButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        closeButton.layer.shadowOpacity = 1.0
        closeButton.layer.shadowRadius = 0.0
        closeButton.layer.masksToBounds = false
        closeButton.layer.cornerRadius = 4.0
    }

    @IBAction func closeController(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveBlur"),
                                        object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerCollectionCells(){
        detailCollectionView.register(UINib(nibName: "MovieHeaderView",
                                            bundle: nil),
                                      forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "MovieDetailHeader")
        detailCollectionView.register(UINib(nibName: "MovieDetailsCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "MovieDetail")
    }
    
}

extension ViewMovieController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: "MovieDetailHeader",
                                                                               for: indexPath) as? MovieHeaderView{
            sectionHeader.populate(postureUrl: postureURL,
                                   name:movieName,
                                   backDropUrl: backDropUrl)
            
            return sectionHeader
            
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetail", for: indexPath) as! MovieDetailsCell
        
        movieCell.populate(overView: movieOverView)
        
        return movieCell
    }
    
    
}

extension ViewMovieController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let sectionHeight:CGFloat = section == 1 ? 210 : 210
        return CGSize(width: self.view.bounds.width, height: sectionHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemHeight:CGFloat = indexPath.section == 1 ? 250:250
        itemHeight = indexPath.section == 2 ? 80 : itemHeight
        let itemWidth:CGFloat = indexPath.section == 2 ? self.view.bounds.width : self.view.bounds.width
        
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
