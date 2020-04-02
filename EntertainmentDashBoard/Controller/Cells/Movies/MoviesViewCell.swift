//
//  MoviesViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/15/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class MoviesViewCell: UICollectionViewCell {
    
    static var movieCellID = "MoviesCell"
    
    lazy var imgView:UIImageView = {
        let vView = UIImageView(frame:.zero)
        vView.translatesAutoresizingMaskIntoConstraints = false
        return vView
    }()
    
    lazy var miniDetailView:UIView = {
        let dView = UIView(frame:.zero)
        dView.translatesAutoresizingMaskIntoConstraints = false
        dView.backgroundColor = globalColor.commonBGKColor
        return dView
    }()
    
    lazy var ratingImgView:UIImageView = {
        let view = UIImageView(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ratingStar")
        return view
    }()
    
    lazy var ratingLabel:UILabel = {
        let view = UILabel(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = "5.0"
        return view
    }()
    
    lazy var nameLabel:UILabel = {
        let view = UILabel(frame:.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        return view
    }()
    
    lazy var vStackView:UIStackView = {
        let vsView = UIStackView(frame:.zero)
        vsView.translatesAutoresizingMaskIntoConstraints = false
        vsView.axis = .vertical
        return vsView
    }()
    
    lazy var hStackView:UIStackView = {
        let hsView = UIStackView(frame:.zero)
        hsView.translatesAutoresizingMaskIntoConstraints = false
        hsView.axis = .horizontal
        hsView.spacing = 10
        return hsView
    }()
    
    var ratingImageSize:(height:CGFloat,width:CGFloat) {
        return (height:20,width:20)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(){
        setImageConstraints()
        setMiniDetailViewConstraints()
        setUpStackViews()
        setCornerRadius()
    }
    
    func setImageConstraints(){
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setMiniDetailViewConstraints(){
        addSubview(miniDetailView)
        miniDetailView.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        miniDetailView.leadingAnchor.constraint(equalTo: imgView.leadingAnchor).isActive = true
        miniDetailView.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
        miniDetailView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        miniDetailView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func setUpStackViews(){
        addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: miniDetailView.topAnchor,constant: 5).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: miniDetailView.leadingAnchor,constant: 5).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: miniDetailView.trailingAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: miniDetailView.bottomAnchor).isActive = true
        
        addControlsToVStackView()
    }
    
    func addControlsToVStackView(){
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(nameLabel)
        addControlToHStackView()
    }
    
    func addControlToHStackView(){
        hStackView.addArrangedSubview(ratingImgView)
        
        ratingImgView.heightAnchor.constraint(equalToConstant: ratingImageSize.height).isActive = true
        ratingImgView.widthAnchor.constraint(equalToConstant: ratingImageSize.width).isActive = true
        
        hStackView.addArrangedSubview(ratingLabel)
    }
    
    func populate(model:MoviesPostureModel){
        let fullUrl = moviePosterBaseUrl + model.posterPath
        let urlPosture = URL(string: fullUrl)
        imgView.sd_setImage(with: urlPosture)
        nameLabel.text = model.movieName
        ratingLabel.text = String(model.voteAvg)
    }
    
    func setCornerRadius(){
        layer.cornerRadius = 10
        clipsToBounds = true
    }

}
