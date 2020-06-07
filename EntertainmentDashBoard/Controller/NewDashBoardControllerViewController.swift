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
                                                         (image:"CricketBkg",title:"Music"),
                                                         (image:"MusicBkg",title:"Cricket"),
                                                         (image:"SettingsBkg",title:"Settings")]
    
    private let refreshControl = UIRefreshControl()
    
    var timer:Timer?
    
    var imgCount:Int = 0

    lazy var dashBoardView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 300)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
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

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func styleViewController(){
        self.title = "Entertainment"
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
       dashBoardView.reloadData()
    }
    
    func setCollectionViewConstraints(){
        let layOut = view.layoutMarginsGuide
        view.addSubview(dashBoardView)
        dashBoardView.topAnchor.constraint(equalTo: layOut.topAnchor).isActive = true
        dashBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dashBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dashBoardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        
        switch row {
        case .zero:
            cell.dashVariant = .news
        case 1:
            cell.dashVariant = .movies
        case 2:
            cell.dashVariant = .tvShows
        case 3:
            cell.dashVariant = .music
        case 4:
            cell.dashVariant = .cricket
        default:
            cell.dashVariant = .settings
        }
       
        cell.populate()
        
    
        cell.seeMoreActionHandler = { [weak self] in
            guard let this = self else{
                return
            }
            
            let controller = NewsViewController()
            this.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        return cell
    }
    
    @objc func imageTapped(_ sender:UITapGestureRecognizer){
        print("selected")
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! DashBoardCell
        
        switch modelDashBoard[indexPath.row].title {
        case "News":
            let controller = NewsViewController()
            controller.selectedImage = cell.selectedImage
            self.navigationController?.pushViewController(controller, animated: true)
        case "Movies":
            let controller = MoviesViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        case "TV":
            let controller = MoviesViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            print("Default")
        }
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size:CGFloat = (collectionView.frame.size.width)
        
        return CGSize(width: size, height: 300)
    }
}
