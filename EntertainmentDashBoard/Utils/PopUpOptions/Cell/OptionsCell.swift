//
//  OptionsCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/31/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell {
    
    static var cellID = "Options"
    
    lazy var labelOptions:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Defautl Text"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        self.backgroundColor = globalColor.commonBGKColor
        setContraints()
    }
    
    func setContraints(){
        contentView.addSubview(labelOptions)
        labelOptions.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelOptions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        labelOptions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        labelOptions.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func populateOptions(value:String){
        labelOptions.text = value
    }
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                backgroundColor = .lightGray
            }else{
                backgroundColor = globalColor.commonBGKColor
            }
        }
    }
}
