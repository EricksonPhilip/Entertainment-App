//
//  DashBoardCellTableViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/8/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit
import SDWebImage

class DashBoardCell: UICollectionViewCell {
    
    static var dashboardCellID = "DashBoardCell"
    
    var viewModel:MoviesViewModel = MoviesViewModel()
    var newsViewModel:NewsViewModel = NewsViewModel()
    
    
    var dashVariant:variant = .news
    
    var timer:Timer?
    
    lazy var bkgImageView:UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.image = UIImage(named:"News-background")
        iView.contentMode = .scaleAspectFill
        return iView
    }()
    
    lazy var title:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello"
        view.textColor = .white
        view.backgroundColor = .darkGray
        view.alpha = 0.7
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
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    func setCornerRadius(){
        contentView.layer.cornerRadius = 15
        bkgImageView.layer.cornerRadius = 15
        bkgImageView.clipsToBounds = true
    }
    
    func populateImage(url:String,isMovies:Bool){
        var fullUrl = ""
        
        if isMovies {
            fullUrl = movievLargeBackDropUrl + url
        }else{
            fullUrl = url
        }
        
        let urlPosture = URL(string: fullUrl)
        
        bkgImageView.sd_setImage(with: urlPosture)
    }
    
    
    func populate(){
        switch dashVariant{
        case .news:
            getTopHeadLineImages()
        case .movies:
             getNowPlayingPostures()
        case .tvShows:
            bkgImageView.image = UIImage(named: "News-background")
        case .cricket:
            bkgImageView.image = UIImage(named: "News-background")
        case .settings:
            bkgImageView.image = UIImage(named: "News-background")
        }
    }
    
    func getNowPlayingPostures(){
        viewModel.getNowPlaying(pageNo:"1"){[weak self] success in
            guard let stongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                if success != 0{
                    let moviePosturesURL = stongSelf.viewModel.model.map{$0.backDropPath}
                    if let randUrl = moviePosturesURL.randomElement(){
                        stongSelf.populateImage(url: randUrl!, isMovies: true)
                    }
                }
            }
        }
    }
    
    func getTopHeadLineImages(){
        newsViewModel.getTopHeadLines(){[weak self] success in
            guard let strongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                if success{
                    let newsPosturesURL = strongSelf.newsViewModel.model.map{$0.newsUrlImage}
                    if let randUrl = newsPosturesURL.randomElement(){
                        strongSelf.populateImage(url: randUrl!, isMovies: false)
                    }
                }
            }
        }
    }
}
