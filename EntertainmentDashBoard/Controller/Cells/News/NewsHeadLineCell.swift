//
//  NewsHeadLineCellTableViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/10/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

protocol cellReadMoreDelegate:AnyObject {
    func readMoreTapped(cell:NewsHeadLineCell)
}

class NewsHeadLineCell: UITableViewCell {
    
    static let NewsCellID = "NewsHeadLineID"
    
    lazy var title:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "[Title]"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var desc:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "[Descriptions]"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imgView:UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.image = UIImage(named:"RainDropBKG")
        iView.contentMode = .scaleToFill
        return iView
    }()
    
    lazy var readMore:UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read More...", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(readMoreButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var spacerView:UIView = {
        let sView = UIView(frame: .zero)
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .black
        return sView
    }()
    
    lazy var stackView:UIStackView = {
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.alignment = .leading
        vStackView.spacing = 5
        return vStackView
    }()
    

    weak var delegate:cellReadMoreDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        backgroundColor = UIColor(red: 27/255.0, green: 38/255.0, blue: 44/255.0, alpha: 1.0)
        setStackViewConstraints()
        addControlsToStackView()
    }
    
    

    func setStackViewConstraints(){
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func addControlsToStackView(){
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(imgView)
        stackView.addArrangedSubview(desc)
        stackView.addArrangedSubview(readMore)
        stackView.addArrangedSubview(spacerView)
        
        title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        title.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        imgView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        imgView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        desc.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        desc.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        readMore.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        readMore.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        spacerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        spacerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setSpacerViewWidth(width:CGFloat){
        spacerView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func populate(model:NewsModel){
        title.text = model.newsTitle
        desc.text = model.newsDesc
        setImageUrl(imageUrl: model.newsImageUrl)
    }
    
    private func setImageUrl(imageUrl:String){
        let url = URL(string: imageUrl)
        imgView.sd_setImage(with: url)
    }

    @objc
    func readMoreButtonAction(){
        delegate?.readMoreTapped(cell: self)
    }
}
