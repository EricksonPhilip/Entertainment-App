//
//  PlayerSquadsController.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/8/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MatchDetailController: UIViewController {

    @IBOutlet weak var squadCollectionView: UICollectionView!
    @IBOutlet weak var viewTypeLabel: UILabel!
    
    var isExpanded:Bool = false
    var selectedIndexPath:IndexPath?
    
    let viewModel:CricketViewModel = CricketViewModel()
    var matchId:String!
    var viewType:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewType == "scorecard"{
            viewTypeLabel.text = "Scorecard"
            setCollectionViewBackgroundView()
            return
        }
    
        setCollectionView()
        registerCell()
        getSquads(matchId: matchId)
        squadCollectionView.backgroundColor = UIColor.black
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setCollectionView(){
        squadCollectionView.dataSource = self
        squadCollectionView.delegate = self
    }
    
    func setCollectionViewBackgroundView(){
        
        let infoView = UIView()
        infoView.frame = CGRect(x: 0, y: 0, width: squadCollectionView.bounds.width, height: 200)
        infoView.center = squadCollectionView.center
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.image = UIImage(named: "UnderConstruction", in: nil, compatibleWith: nil)
        infoView.addSubview(imageView)
        imageView.center.x = infoView.center.x
        
        let infoLabel = UILabel()
        infoLabel.frame = CGRect(origin: CGPoint(x: 0, y: 45), size: CGSize(width: infoView.bounds.width,
                                                                    height: 30))
        infoLabel.text = "Scoreboard is coming soon......"
        infoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.white
        
        infoView.addSubview(infoLabel)
        
        squadCollectionView.backgroundView = infoView
    }
    
    func registerCell(){
        squadCollectionView.register(UINib(nibName: "MainSectionHeaderView",
                                               bundle: nil),
                                         forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "MainSection")
        squadCollectionView.register(UINib(nibName: "SquadsCell",
                                             bundle: nil),
                                       forCellWithReuseIdentifier: "Squads")
    }
    
    func getSquads(matchId:String){
        viewModel.getSquads(matchId: matchId){
            success in
            if success{
                DispatchQueue.main.async {
                    self.squadCollectionView.reloadData()
                }
            }
        }
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MatchDetailController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfTeams()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.squadsModel[section].players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: "MainSection",
                                                                               for: indexPath) as? MainSectionHeaderView{
            
            let headerName =  viewModel.squadsModel[indexPath.section].teamName
            
            sectionHeader.sectionheaderLabel.text = headerName
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let squadsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Squads",
                                                               for: indexPath) as! SquadsCell
        
        squadsCell.populate(model: viewModel.squadsModel[indexPath.section].players[indexPath.row])
        
        return squadsCell
    }
    
    
}

extension MatchDetailController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MatchDetailController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let sectionHeight:CGFloat = 60
        return CGSize(width: collectionView.bounds.width, height: sectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 73)

    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 5 )
    }
}

