//
//  MatchesCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/14/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import PopMenu

class MatchesCell: UICollectionViewCell {
    
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var matchTypelabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var scoreViewModel:CricketViewModel = CricketViewModel()
    var context = CIContext(options: nil)
    
    var matchId:Int = 0
    
    override func awakeFromNib() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.backgroundColor = globalColor.cellBackground
    }
    
    func setClearForLabels(label:UILabel){
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0.5
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0, height: -0.5) 
    }
        
    func populate(model:CricketModel){
        matchId = model.uniqueId
        team1Label.text = model.team1
        team2Label.text = model.team2
        matchTypelabel.text = model.matchType
        getScore(uniqueId: String(model.uniqueId))
    }
    
    func setScore(id:String){
        if scoreViewModel.scoreModel!.isStarted{
            scoreLabel.text = scoreViewModel.scoreModel!.Score
        }else{
            scoreLabel.text = "Match hasn't started yet!"
        }
    }
    
    func getScore(uniqueId:String){
        scoreViewModel.getScore(uniqueId: uniqueId){
            success in
            
            if success{
                DispatchQueue.main.async {
                    self.setScore(id:uniqueId)
                }
            }
        }
    }
    
    func setShadowDrop(){
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(0.5), height: CGFloat(0.5))
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func showPopUpMenu(){
        let popMenuManager = PopMenuManager.default
        popMenuManager.popMenuDelegate = self
        popMenuManager.popMenuAppearance.popMenuColor = .configure(background: .solid(fill: UIColor.white),
                                                                   action: .tint(UIColor.black))
        popMenuManager.popMenuAppearance.popMenuPresentationStyle = .cover()
        
        popMenuManager.actions = [
            PopMenuDefaultAction(title: "View Score"),
            PopMenuDefaultAction(title:"View Squad")
        ]
        
        popMenuManager.present(sourceView: moreButton)
    }
    
    func showList(type:String){
        
        let matchDetailBoard =  UIStoryboard.init(name: "EntertainmentBoard", bundle: nil)
        let matchDetailController = matchDetailBoard.instantiateViewController(withIdentifier: "Squads") as! MatchDetailController
        matchDetailController.matchId = String(matchId)
        
        let _type = type == "squad" ? "squad":"scorecard"
        matchDetailController.viewType = _type
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(matchDetailController, animated: false, completion: nil)
        }
    }
    
    
    
    @IBAction func moreAction(_ sender: Any) {
        showMoreActionSheet()
    }
    
    func showMoreActionSheet(){
        let moreOptionMenu: UIAlertController = UIAlertController(title: nil, message: nil,
                                                                  preferredStyle: .actionSheet)
        
        moreOptionMenu.setBackground(textColor: UIColor.lightGray,
                                     background: globalColor.alertControllerBackground)
        
        let squadImage = UIImage(named: "ProfilePlaceHolder")
        let scoreImage = UIImage(named: "ScoreCard")
        
        let squadActionButton = UIAlertAction(title: "View Squad", style: .default) { _ in
            self.showList(type: "squad")
        }
        
        squadActionButton.setImage(image: squadImage!)
        
        moreOptionMenu.addAction(squadActionButton)
        
        let scoreActionButton = UIAlertAction(title: "View Scorecard", style: .default){ _ in
            self.showList(type: "scorecard")
        }
        
        scoreActionButton.setImage(image: scoreImage!)
        
        moreOptionMenu.addAction(scoreActionButton)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .default){ _ in
            print("Cancelled")
        }
        moreOptionMenu.addAction(cancelActionButton)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(moreOptionMenu, animated: false, completion: nil)
        }
    }
    
   
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}

extension MatchesCell:PopMenuViewControllerDelegate{
    
}

