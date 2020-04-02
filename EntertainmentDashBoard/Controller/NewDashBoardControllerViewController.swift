//
//  NewDashBoardControllerViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/8/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class NewDashBoardControllerViewController: UIViewController {
    
    var viewModel:MoviesViewModel = MoviesViewModel()
    var newsViewModel:NewsViewModel = NewsViewModel()
    
    var newsImages:[String] = [String]()
    var moviesImages:[String] = [String]()
    
    let modelDashBoard :[(image:String,title:String)] = [(image:"NewsBkgSet",title:"News"),
                                                         (image:"Joker4k-1024",title:"Movies"),
                                                         (image:"Friends",title:"TV show"),
                                                         (image:"CricketBkg",title:"Cricket"),
                                                         (image:"MusicBkg",title:"Music"),
                                                         (image:"SettingsBkg",title:"Settings")]
    
    private let refreshControl = UIRefreshControl()
    
    var timer:Timer?
    
    var imgCount:Int = 0

    lazy var dashBoardView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,
                                         collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViewController()
        configureDashBoardCollectionView()
        setCollectionViewConstraints()
        addRefreshControl()
        
        dashBoardView.reloadData()
        
        getNewsImages()
        getMoviesImages()
        
        Timer.scheduledTimer(timeInterval: 2.0,
                             target: self,
                             selector: #selector(setmulipleImages),
                             userInfo: nil,
                             repeats: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func styleViewController(){
        self.title = "Entertainment"
        navigationController?.navigationBar.tintColor = .black
        dashBoardView.backgroundColor = UIColor(red: 27/255.0, green: 38/255.0, blue: 44/255.0, alpha: 1.0)
    }
    

    func configureDashBoardCollectionView(){
        registerDashBoardCell()
        dashBoardView.dataSource = self
        dashBoardView.delegate = self
    }
    
    func registerDashBoardCell(){
        dashBoardView.register(DashBoardCell.self, forCellWithReuseIdentifier: DashBoardCell.dashboardCellID)
        dashBoardView.register(HeaderDashBoardView.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                               withReuseIdentifier: HeaderDashBoardView.resuableViewID)
    }
    
    func addRefreshControl(){
        refreshControl.tintColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Updating ...", attributes: attributes)

        refreshControl.addTarget(self, action: #selector(refreshDashBoardData(_:)), for: .valueChanged)
        dashBoardView.refreshControl = refreshControl
    }
    
    @objc private func refreshDashBoardData(_ sender: Any) {
       //loadDashBoardViews()
    }
    
    func setCollectionViewConstraints(){
        let layOut = view.layoutMarginsGuide
        view.addSubview(dashBoardView)
        dashBoardView.topAnchor.constraint(equalTo: layOut.topAnchor).isActive = true
        dashBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dashBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dashBoardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func getNewsImages() {
        newsViewModel.getTopHeadLines(){ [weak self] success in
            guard let _self = self else{
                return
            }
            if success{
                let _images = _self.newsViewModel.model.map{$0.newsUrlImage}
                
                _self.newsImages = _images as! [String]
            }
        }
    }
    
    func getMoviesImages(){
        viewModel.getNowPlaying(pageNo: "1"){ [weak self] success in
            guard let _self = self else{
                return
            }
            
            if success > 0{
                let _images = _self.viewModel.model.map{$0.backDropPath}
                
                _self.moviesImages = _images as! [String]
            }
        }
    }
    
    @objc func setmulipleImages(){
        dashBoardView.performBatchUpdates(nil, completion: {
            (result) in
            if let newsCell = self.dashBoardView.cellForItem(at: IndexPath(item: 0, section: 0)) as? DashBoardCell,
               let movieCell = self.dashBoardView.cellForItem(at: IndexPath(item: 0, section: 0)) as? MoviesViewCell{
                
                if self.imgCount > self.newsImages.count-1 {
                  return
                }
                
                newsCell.populateImage(url: self.newsImages[self.imgCount], isMovies: false)
                //movieCell.populateImage(url: self.newsImages[self.imgCount], isMovies: true)
                
                self.imgCount += 1
                
            }
        })
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelDashBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashBoardCell.dashboardCellID,
                                                      for: indexPath) as! DashBoardCell
        let row = indexPath.row
                
        cell.title.text = modelDashBoard[row].title
        
        if row == 0 {
            cell.dashVariant = .news
        }else if row == 1{
            cell.dashVariant = .movies
        }
        else{
            cell.dashVariant = .cricket
        }
        
        
        cell.populate()
        
        return cell
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch modelDashBoard[indexPath.row].title {
        case "News":
            let controller = NewsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case "Movies":
            let controller = MoviesViewController()
            controller.modalPresentationStyle = .formSheet
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            print("Default")
        }
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        
        return CGSize(width: size, height: 250)
    }

}
