//
//  MainSectionHeaderView.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/16/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class MainSectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var sectionheaderLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        //setClearForLabels(label: sectionheaderLabel)
    }
    
    func setClearForLabels(label:UILabel){
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0.5
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0, height: -0.5)
    }
}
