//
//  DashBoardCellTableViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/8/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class DashBoardCell: UICollectionViewCell {
    
    static var dashboardCellID = "DashBoardCell"
    
    lazy var bkgImageView:UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.image = UIImage(named:"Joker4k-1024")
        iView.contentMode = .scaleToFill
        return iView
    }()
    
    lazy var title:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello"
        view.textColor = .white
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        contentView.backgroundColor = .white
        setBackGroundImageView()
        setTitleConstrainsts()
        setCornerRadius()
    }
    
    func setBackGroundImageView(){
        contentView.addSubview(bkgImageView)
        bkgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bkgImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bkgImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bkgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setTitleConstrainsts(){
        contentView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5).isActive = true
    }
    
    
    func setCornerRadius(){
        contentView.layer.cornerRadius = 15
        bkgImageView.layer.cornerRadius = 15
        bkgImageView.clipsToBounds = true
    }
}
