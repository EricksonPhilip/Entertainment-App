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
    
    lazy var vStackView:UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .leading
        view.spacing = 1
        return view
    }()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "defaultMovieImage")
        return view
    }()
    
    lazy var title:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello"
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
        setStackViewConstraints()
        addButtonsToStackView()
        setCornerRadius()
    }
    
    func setStackViewConstraints(){
        contentView.addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5).isActive = true
    }
    
    func addButtonsToStackView(){
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(title)
        
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setCornerRadius(){
        contentView.layer.cornerRadius = 15
    }
}
