//
//  SquadSectionHeaderView.swift
//  EntertainmentDashBoard
//
//  Created by RathinaPandi, EricksonPhilip (TCS) on 3/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class SquadSectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var rolePlayingLabel: UILabel!
    
    var viewModel:CricketViewModel = CricketViewModel()
    
    override func awakeFromNib() {
        setRoundedCornerOnImage()
        self.backgroundColor = globalColor.cellBackground
    }
    
    func setRoundedCornerOnImage(){
        imgPlayer.layer.cornerRadius = self.imgPlayer.frame.width/2
        imgPlayer.clipsToBounds = true
    }
    
    func populate(model:PlayerModel){
        playerNameLabel.text = model.PlayerName
        viewModel.getPlayerImageUrl(pId: String(model.playerId)){
            imageUrl,playingRole in
            DispatchQueue.main.async {
                self.setPlayerImageUrl(playerImageUrl: imageUrl)
                self.rolePlayingLabel.text = playingRole
            }
        }
    }
    
    private func setPlayerImageUrl(playerImageUrl:String){
        let urlPlayerImage = URL(string: playerImageUrl)
        
        imgPlayer!.sd_setImage(with: urlPlayerImage,
                               placeholderImage: UIImage(named: "ProfilePlaceHolder"),
                               options:.delayPlaceholder ,
                               completed: nil)
        
    }
        
}
