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
        button.setTitleColor(.lightGray, for: .normal)
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
    
    override func layoutSubviews() {
        spacerView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    }

    func setUp(){
        backgroundColor = UIColor(red: 27/255.0, green: 38/255.0, blue: 44/255.0, alpha: 1.0)
        setStackViewConstraints()
        addControlsToStackView()
    }
    

    func setStackViewConstraints(){
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func addControlsToStackView(){
        
        stackView.addArrangedSubview(spacerView)
        spacerView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        spacerView.backgroundColor = .white
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(imgView)
        stackView.addArrangedSubview(desc)
        stackView.addArrangedSubview(readMore)
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
                
        let heightCont = imgView.heightAnchor.constraint(equalToConstant: 300)
        heightCont.priority = UILayoutPriority(999)
        heightCont.isActive = true
    }
    
    func setSpacerViewWidth(width:CGFloat){
        spacerView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func populate(model:NewsModel){
        title.text = model.newsTitle
        desc.text = model.newsDesc
        setImageUrl(imageUrl: model.newsImageUrl!)
    }
    
    private func setImageUrl(imageUrl:String){
        let url = URL(string: imageUrl)
        imgView.sd_setImage(with: url, completed: {
            (image, error, cacheType, url) in
            if image == nil{
                self.imgView.isHidden = true
            }
        })
    }

    @objc
    func readMoreButtonAction(){
        delegate?.readMoreTapped(cell: self)
    }
    
    ////Later use
    func shrink(down:Bool,cell:NewsHeadLineCell){
        UIView.animate(withDuration: 0.6) {
            if down {
                cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            else{
                cell.transform = .identity
            }
        }
    }

}
