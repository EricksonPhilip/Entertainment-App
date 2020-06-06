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
    
    var moviewViewModel:MoviesViewModel = MoviesViewModel()
    var newsViewModel:NewsViewModel = NewsViewModel()
    var tvViewModel:PopularTvViewModel = PopularTvViewModel()
    var musicViewModel:MusicViewModel = MusicViewModel()
    var cricketViewModel:CricketViewModel = CricketViewModel()
    
    var dashVariant:variant = .news
    
    var seeMoreActionHandler:(()->Void)?
    
    var timer = Timer()
    
    var nextButtonWidthConst:NSLayoutConstraint?
    
   
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy var hStackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var title:UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello"
        view.textColor = .white
        view.backgroundColor = globalColor.commonBGKColor
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 19)
        view.alpha = 0.7
        return view
    }()
    
    lazy var nextButton:UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "next"), for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(nextSlide(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var previousButton:UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(previousSlide(_:)), for: .touchUpInside)
        return button
    }()
    
    var matchViews:[CricketMatchesView] = [CricketMatchesView]()
    var imageViews:[ImageWithCaptionView] = [ImageWithCaptionView]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        nextButton.roundCorners(corners: [.topLeft,.bottomLeft], radius: 20)
        previousButton.roundCorners(corners: [.topRight,.bottomRight], radius: 20)
    }
    
    func setUp(){
        setScrollViewConstraints()
        setTitleConstrainsts()
        navigationButtonConstrainsts()
    }
    
    func setScrollViewConstraints(){
        contentView.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setTitleConstrainsts(){
        contentView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func navigationButtonConstrainsts(){
        nextButtonConstrainst()
        previousButtonConstrainst()
    }
    
    func nextButtonConstrainst(){
        contentView.addSubview(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButtonWidthConst = nextButton.widthAnchor.constraint(equalToConstant: 40)
        nextButtonWidthConst?.isActive = true
        
        styleButton(button: nextButton)
    }
    
    func previousButtonConstrainst(){
        contentView.addSubview(previousButton)
        previousButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        previousButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        styleButton(button: previousButton)
    }
    
    func styleButton(button:UIButton){
        button.backgroundColor = globalColor.alertControllerBackground
        button.setTitleColor(.white, for: .normal)
    }
    
    func addStuffsToScrollView(){
        scrollView.contentSize = CGSize(width: (bounds.width-10) * 5,
                                          height: 300)
        
        scrollView.addSubview(hStackView)
        
        hStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        switch dashVariant {
        case .news,.movies,.tvShows,.music,.settings:
            addImagesViewToScrollView()
        case .cricket:
            addMatchesToScrolleView()
        }
        
        self.layoutIfNeeded()
    }
    
    func addImagesViewToScrollView(){
        for i in 0...4{
            let view = ImageWithCaptionView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            imageViews.append(view)
    
            hStackView.addArrangedSubview(imageViews[i])
            
            imageViews[i].heightAnchor.constraint(equalToConstant: 300).isActive = true
            imageViews[i].widthAnchor.constraint(equalToConstant: bounds.width-10).isActive = true
            
            imageViews[i].isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer()
            tapGesture.numberOfTapsRequired = 1
            tapGesture.addTarget(self, action: #selector(tapped))
            imageViews[i].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func tapped(_ sender:UITapGestureRecognizer){
        print("selected")
    }
    
    func addMatchesToScrolleView(){
        for i in 0...4{
            let view = CricketMatchesView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            matchViews.append(view)
            
            hStackView.addArrangedSubview(matchViews[i])
            
            matchViews[i].heightAnchor.constraint(equalToConstant: 300).isActive = true
            matchViews[i].widthAnchor.constraint(equalToConstant: bounds.width-10).isActive = true
        }
    }
    
    @objc func nextSlide(_ sender:UIButton){
        let scrollWidth = bounds.width-10
        let currentXOffset = scrollView.contentOffset.x
        
        let lastXPos = currentXOffset + scrollWidth
        
        if self.nextButton.titleLabel?.text == "More.."{
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            self.nextButtonWidthConst?.constant = 50
            self.nextButton.setTitle("", for: .normal)
            self.nextButton.setImage(UIImage(named: "next"), for: .normal)
           
            if let seeMoreAction = seeMoreActionHandler{
                seeMoreAction()
            }
        }
        
        UIView.animate(withDuration: 0.2){
            if lastXPos != self.scrollView.contentSize.width {
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: .zero), animated: true)
            }else{
                self.nextButtonWidthConst?.constant = 100.0
                self.nextButton.setTitle("More..", for: .normal)
                self.nextButton.setImage(UIImage(named: ""), for: .normal)
            }
        }
    }
    
    @objc func previousSlide(_ sender:UIButton){
        let scrollWidth = bounds.width-10
        let currentXOffset = scrollView.contentOffset.x
        
        let lastXPos = currentXOffset - scrollWidth
        
        UIView.animate(withDuration: 0.2){
            if lastXPos != self.scrollView.contentSize.width {
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: .zero), animated: true)
            }
        }
    }
    
    @objc func animateScrollView() {
        let scrollWidth = bounds.width
        let currentXOffset = scrollView.contentOffset.x

        let lastXPos = currentXOffset + scrollWidth
        
        UIView.animate(withDuration: 0.2){
            if lastXPos != self.scrollView.contentSize.width {
                self.scrollView.setContentOffset(CGPoint(x: lastXPos, y: .zero), animated: true)
            }
            else {
                self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            }
        }
    }


    func populate(){
        
        addStuffsToScrollView()
        
        switch dashVariant{
        case .news:
            getTopHeadLineImages()
        case .movies:
             getNowPlayingPostures()
        case .tvShows:
             getPoppularTvShows()
        case .music:
            getTopMusicTracks()
        case .cricket:
            getCricketMatches()
        case .settings:
            print("Nothing!")
        }
    }
    
    func getNowPlayingPostures(){
        moviewViewModel.getNowPlaying(pageNo:"1"){[weak self] success in
            guard let this = self else{
                return
            }
            DispatchQueue.main.async {
                if success != 0{
                    let moviePosturesURL = this.moviewViewModel.model.map{$0.backDropPath}
                    let titleUrl = this.moviewViewModel.model.map{$0.movieName}
                    
                    var firstFiveUrls:[(url:String,title:String)] = [(url:String,title:String)]()
                    
                    for  i in  0...4{
                        firstFiveUrls.append((url:(moviePosturesURL[i] ?? "") as String,title:titleUrl[i]! as String))
                    }
                    
                    this.populateImage(urls: firstFiveUrls, type:this.dashVariant)
                }
            }
        }
    }
    
    func getTopHeadLineImages(){
        newsViewModel.getTopHeadLines(){[weak self] success in
            guard let this = self else{
                return
            }
            DispatchQueue.main.async {
                if success{
                    let newsPosturesURL = this.newsViewModel.model.map{$0.newsUrlImage}
                    let titleUrl = this.newsViewModel.model.map{$0.newsTitle}
                    
                    var firstFiveUrls:[(url:String,title:String)] = [(url:String,title:String)]()
                    
                    for  i in  0...4{
                        firstFiveUrls.append((url:(newsPosturesURL[i] ?? "") as String,title:titleUrl[i]! as String))
                    }
                    
                    this.populateImage(urls: firstFiveUrls, type:this.dashVariant)
                }
            }
        }
    }
    
    func getPoppularTvShows(){
        tvViewModel.getPopularTvShows(){[weak self] success in
            DispatchQueue.main.async {
                guard let this = self else{
                    return
                }
                if success{
                    let newsPosturesURL = this.tvViewModel.model.map{$0.backDropPath}
                    let titleUrl = this.tvViewModel.model.map{$0.name}
                    
                    var firstFiveUrls:[(url:String,title:String)] = [(url:String,title:String)]()
                    
                    for  i in  0...4{
                        firstFiveUrls.append((url:(newsPosturesURL[i] ?? "") as String,title:titleUrl[i]! as String))
                    }
                    
                    this.populateImage(urls: firstFiveUrls, type:this.dashVariant)
                }
            }
        }
    }
    
    func getTopMusicTracks(){
        musicViewModel.getTopArtists(){ [weak self] success in
            guard let this = self else{
                return
            }
            if success{
                let imageUrl = this.musicViewModel.model.map{$0.imageUrl}
                let titleUrl = this.musicViewModel.model.map{$0.artistName}
                
                var firstFiveUrls:[(url:String,title:String)] = [(url:String,title:String)]()
                
                for  i in  0...4{
                    firstFiveUrls.append((url:(imageUrl[i] ?? "") as String,title:titleUrl[i]! as String))
                }
                
                this.populateImage(urls: firstFiveUrls, type:this.dashVariant)
            }
        }
    }
    
    func getCricketMatches(){
        cricketViewModel.getNewMatches(){[weak self] success in
            guard let this = self else{
                return
            }
            
            let teamOne = this.cricketViewModel.model.map{$0.team1}
            let teamTwo = this.cricketViewModel.model.map{$0.team2}
            let matchType = this.cricketViewModel.model.map{$0.matchType}
            let score = this.cricketViewModel.model.map{$0.Score}
            
            var matches:[(teamOne:String,teamTwo:String,matchType:String,score:String)] = [(teamOne:String,
                                                                               teamTwo:String,
                                                                               matchType:String,score:String)]()
            
            for  i in  0...4{
                matches.append((teamOne: (teamOne[i] ?? "NA") as String,
                                teamTwo: (teamTwo[i] ?? "NA") as String,
                                matchType: (matchType[i] ?? "NA") as String,
                                score: (score[i] ?? "NA") as String))
            }
            
            this.populateMatches(datas: matches)
        }
    }

    
    func populateImage(urls:[(url:String,title:String)],type:variant){
        switch type {
        case .movies,.tvShows:
            for i in 0...urls.count-1{
                let urlOne = movievLargeBackDropUrl + urls[i].url
                imageViews[i].setImage(strUrl: urlOne)
                DispatchQueue.main.async {
                    self.imageViews[i].topTitleText = urls[i].title
                }
            }
            
        default:
            for i in 0...urls.count-1{
                let urlOne =  urls[i].url
                imageViews[i].setImage(strUrl: urlOne)
                DispatchQueue.main.async {
                    self.imageViews[i].topTitleText = urls[i].title
                }
            }
        }
    }
    
    func populateMatches(datas:[(teamOne:String,teamTwo:String,matchType:String,score:String)]){
        for i in 0...datas.count-1{
            DispatchQueue.main.async {
                self.matchViews[i].teamOneLabel.text = datas[i].teamOne
                self.matchViews[i].teamTwoLabel.text = datas[i].teamTwo
                self.matchViews[i].matchTypeLabel.text = datas[i].matchType
                self.matchViews[i].scoreLabel.text = datas[i].score
            }
        }
    }
}
