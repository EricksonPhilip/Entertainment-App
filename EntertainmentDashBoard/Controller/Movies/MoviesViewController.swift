//
//  MoviesViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/15/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    lazy var pagingNumberView:PagingNumberView = {
        let view = PagingNumberView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
   

    var selectedImage:Int = .zero
    
    var viewModel:MoviesViewModel = MoviesViewModel()
    
    var discoverTitleView:UIButton = UIButton()
    
    var numberArray:[String] = [String]()
    
    var currPage:Int = 1
    
    var currVariant:MovieTypeList = .nowPlaying
    
    private let refreshControl = UIRefreshControl()
    
    var pagingViewHeightConst:NSLayoutConstraint?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = globalColor.commonBGKColor
        configureCollectionView()
        addDiscoverViewNavigationBar()
        addRefreshControl()
        setPaginViewConstraints()
        setCollectionViewConstraint()
        getMovies(variant: .nowPlaying, pageNo: 1)
        handlePageTapped()
        
        let selectedIndexPath = IndexPath(item: selectedImage, section: 0)
        
        collectionView.scrollToItem(at: selectedIndexPath, at: .bottom, animated: true)
    }
    
    func addDiscoverViewNavigationBar(){
        
        discoverTitleView = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
        
        discoverTitleView.setTitle("Now Playing", for: .normal)
        discoverTitleView.addTarget(self, action: #selector(titleViewTapped), for: .touchUpInside)
        
        self.navigationItem.titleView = discoverTitleView
            
    }
    
    func addRefreshControl(){
        refreshControl.tintColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Updating ...", attributes: attributes)

        refreshControl.addTarget(self, action: #selector(refreshMovieData(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshMovieData(_ sender: Any) {
        getMovies(variant: currVariant, pageNo: currPage)
    }
    
    @objc func titleViewTapped(){
        self.view.alpha = 0.7
        
        let optionsController = PopUpViewController()
        optionsController.modalPresentationStyle = .overFullScreen
        optionsController.arrayOptions =  MovieTypeList.lists
    
        present(optionsController, animated: true, completion: nil)
        
        optionsController.didTappedAction = { [weak self] movieType in
            guard let this = self else{
                return
            }
            
            this.getMovies(variant: movieType, pageNo: this.currPage)
           
            this.view.alpha = 1
            
            this.discoverTitleView.setTitle(movieType.get(), for: .normal)
            
            DispatchQueue.main.async {
                this.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    func registerCollectionViewCell(){
        collectionView.register(MoviesViewCell.self,
                                     forCellWithReuseIdentifier: MoviesViewCell.movieCellID)
    }
    
    func configureCollectionView(){
        registerCollectionViewCell()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setPaginViewConstraints(){
        let layOut = view.layoutMarginsGuide
        view.addSubview(pagingNumberView)
        pagingNumberView.topAnchor.constraint(equalTo: layOut.topAnchor,constant: 10).isActive = true
        pagingNumberView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pagingNumberView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        pagingViewHeightConst = pagingNumberView.heightAnchor.constraint(equalToConstant: 60)
        pagingViewHeightConst?.isActive = true
    }
    
    func setCollectionViewConstraint(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: pagingNumberView.bottomAnchor,constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: pagingNumberView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: pagingNumberView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func beginRefreshingControl(){
        self.collectionView.setContentOffset(CGPoint(x: .zero,
                                                     y: -self.refreshControl.frame.size.height),
                                             animated: true)
        self.refreshControl.beginRefreshing()
    
    }
    
    func getMovies(variant:MovieTypeList,pageNo:Int){
        viewModel.model = [MoviesPostureModel]()
        
        beginRefreshingControl()
        
        viewModel.getMovies(variant: variant, pageNo: String(pageNo)){ [weak self] pages in
            guard let this = self else{
                return
            }

            DispatchQueue.main.async {
                
                if pages > 0{
                    this.appendTotalPagesToArray(val: pages)
                }
                
                this.collectionView.reloadData()
                this.collectionView.scrollToItem(at: IndexPath(item: .zero, section: .zero), at: .top, animated: true)
                this.refreshControl.endRefreshing()
                
                this.currVariant = variant
                
            }
        }
    }
    

    func appendTotalPagesToArray(val:Int){
        numberArray = [String]()
        for i in 1...val{
            numberArray.append(String(i))
        }
        pagingNumberView.numberArray = numberArray
    }
    
    func handlePageTapped(){
        pagingNumberView.pageTapAction = {[weak self] number in
            guard let this = self else{
                return
            }
            
            this.getMovies(variant: this.currVariant, pageNo: number)

            this.currPage = number
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
        
        if viewModel.model.indices.contains(indexPath.row){
            let model = viewModel.model[indexPath.row]
            cell.populate(model: model)
        }
           
        return cell
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
        return CGSize(width: size, height: 400)
    }
    
}
