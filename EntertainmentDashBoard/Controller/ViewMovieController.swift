//
//  ViewCricketScoreController.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/16/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class ViewMovieController: UIViewController {

    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let closeImg = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(closeImg, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    
    
    lazy var navigationView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = globalColor.commonBGKColor
        return view
    }()
    
    lazy var navigationTitleView: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = movieName
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 25)
        view.textAlignment = .left
        return view
    }()
    
    lazy  var detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        return collView
    }()
    
    public var postureURL:String!
    public var movieName:String!
    public var movieOverView:String!
    public var backDropUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCells()
        setNavLayout()
        setStyleCloseButton()
        styleTitleNavigationView()
        setCollectionView()
    }
    
    func setNavLayout(){
        NavConstraints()
    }
    
    func NavConstraints(){
        let layutGuide = view.layoutMarginsGuide
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: layutGuide.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    
    func setStyleCloseButton(){
        closeButtonConstraints()
        
        closeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        closeButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        closeButton.layer.shadowOpacity = 1.0
        closeButton.layer.shadowRadius = 0.0
        closeButton.layer.masksToBounds = false
        closeButton.layer.cornerRadius = 4.0
    }
    
    func closeButtonConstraints(){
        navigationView.addSubview(closeButton)
        
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true

    }
    
    func styleTitleNavigationView(){
        let titleWidth = UIScreen.main.bounds.width - 55
        navigationView.addSubview(navigationTitleView)
        navigationTitleView.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        navigationTitleView.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true
        navigationTitleView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        navigationTitleView.widthAnchor.constraint(equalToConstant: titleWidth).isActive = true
    }
    
    func setCollectionView(){
        setCollViewConstraints()
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    func setCollViewConstraints(){
        view.addSubview(detailCollectionView)
        detailCollectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailCollectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    

     @objc func closeController() {
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
