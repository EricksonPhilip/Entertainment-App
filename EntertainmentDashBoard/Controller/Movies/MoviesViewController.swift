//
//  MoviesViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/15/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel:MoviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        getNowPlayingMovies(pageNo: 1)
    }
    
    func registerCollectionViewCell(){
        self.collectionView.register(MoviesViewCell.self,
                                     forCellWithReuseIdentifier: MoviesViewCell.movieCellID)
        collectionView.register(HeaderDashBoardView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderDashBoardView.resuableViewID)
    }
    
    func configureCollectionView(){
        registerCollectionViewCell()
        collectionView.dataSource = self
        collectionView.delegate = self
        setCollectionViewConstraint()
    }
    
    func setCollectionViewConstraint(){
        let layOut = view.layoutMarginsGuide
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: layOut.topAnchor,constant: -5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func getNowPlayingMovies(pageNo:Int){
        viewModel.getNowPlaying(pageNo:String(pageNo)){[weak self] success in
            guard let stongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                if success{
                    stongSelf.collectionView.reloadData()
                }
            }
        }
    }
}

extension MoviesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPostures()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesViewCell.movieCellID,
                                                      for: indexPath) as! MoviesViewCell
        
        let model = viewModel.model[indexPath.row]
        
        cell.populate(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: HeaderDashBoardView.resuableViewID, for: indexPath) as! HeaderDashBoardView
            
            reusableview.headerTitle.text = "Now playing Movies"
            
            reusableview.imageView.image = UIImage(named: "MoviePlaceHolder")?.withRenderingMode(.alwaysTemplate)
            reusableview.imageView.tintColor = .white
            
            reusableview.backgroundColor = .darkGray

            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
}

extension MoviesViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postureModel = viewModel.model[indexPath.row]
        
        let ViewMovieDetail = ViewMovieController()
        
        ViewMovieDetail.postureURL = postureModel.posterPath
        ViewMovieDetail.movieName = postureModel.movieName
        ViewMovieDetail.movieOverView = postureModel.movieOverView
        ViewMovieDetail.backDropUrl = postureModel.backDropPath
        
        present(ViewMovieDetail, animated: true, completion: nil)
    }
}

extension MoviesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 65)
    }
    
}
