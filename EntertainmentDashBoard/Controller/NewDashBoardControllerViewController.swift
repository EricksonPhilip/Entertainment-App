//
//  NewDashBoardControllerViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/8/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class NewDashBoardControllerViewController: UIViewController {
    
    let modelDashBoard :[(image:String,title:String)] = [(image:"defaultMovieImage",title:"News"),
                                                         (image:"MoviePlaceHolder",title:"Movies"),
                                                         (image:"defaultTV",title:"TV show"),
                                                         (image:"next",title:"Cricket"),
                                                         (image:"close",title:"Music"),
                                                         (image:"UnderConstruction",title:"Settings")]

    lazy var dashBoardView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func styleViewController(){
        self.title = "Entertainment"
        navigationController?.navigationBar.tintColor = .black
        dashBoardView.backgroundColor = .black
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
    
    func setCollectionViewConstraints(){
        let layOut = view.layoutMarginsGuide
        view.addSubview(dashBoardView)
        dashBoardView.topAnchor.constraint(equalTo: layOut.topAnchor).isActive = true
        dashBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dashBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dashBoardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //dashBoardView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
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
        cell.imageView.image = UIImage(named: modelDashBoard[row].image)
        cell.title.text = modelDashBoard[row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: HeaderDashBoardView.resuableViewID, for: indexPath) as! HeaderDashBoardView

                return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
    
    
}

extension NewDashBoardControllerViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = NewsViewController()
        self.present(controller, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.white
    }
}

extension NewDashBoardControllerViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 64)
    }
    
    
}
