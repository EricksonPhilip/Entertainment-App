//
//  ViewController.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class DashBoardController: UIViewController{

    
    @IBOutlet weak var dashBoardCollectionView: UICollectionView!
    var modelArray:[DashBoardList] = [DashBoardList]()
    var movieViewModel:MoviesViewModel = MoviesViewModel()
    var weatherViewModel = WeatherViewModel()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Entertainment"
        getWeatherData()
        setDashBoardArray()
        registerCells()
        setSourceAndDelegateForCollectionView()
        
    }
    
    func registerCells(){
        dashBoardCollectionView.register(UINib(nibName: "MainSectionHeaderView",
                                               bundle: nil),
                                         forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "MainSection")
        dashBoardCollectionView.register(UINib(nibName: "CricketCell",
                                               bundle: nil),
                                         forCellWithReuseIdentifier: "cricket")
        dashBoardCollectionView.register(UINib(nibName: "MovieCell",
                                               bundle: nil),
                                         forCellWithReuseIdentifier: "movies")
        dashBoardCollectionView.register(UINib(nibName: "TvCell",
                                               bundle: nil),
                                         forCellWithReuseIdentifier: "TV")
        dashBoardCollectionView.register(UINib(nibName: "NewsCell",
                                               bundle: nil),
                                         forCellWithReuseIdentifier: "news")
        dashBoardCollectionView.register(UINib(nibName: "WeatherCell",
                                               bundle: nil), forCellWithReuseIdentifier: "weather")
        dashBoardCollectionView.register(UINib(nibName: "ArtistsCollectionCell",
                                               bundle: nil), forCellWithReuseIdentifier: "MusicCell")
    }
    
    func setSourceAndDelegateForCollectionView(){
        dashBoardCollectionView.dataSource = self
        dashBoardCollectionView.delegate = self
    }
    
    func setDashBoardArray(){
        modelArray.append(.news)
        modelArray.append(.weather)
        modelArray.append(.cricket)
        modelArray.append(.movies)
        modelArray.append(.tv)
        modelArray.append(.music)
        
    }
    
    func setCollectionViewBackGround(){
        let shimmeringView = UIView()
        shimmeringView.frame = CGRect(origin: dashBoardCollectionView.frame.origin,
                                      size:dashBoardCollectionView.bounds.size)
        shimmeringView.backgroundColor = UIColor.lightGray
        shimmeringView.startShimmeringAnimation()
        
        dashBoardCollectionView.backgroundView = shimmeringView
    }
    
    func applyBlurEffect(imageView:UIImageView) {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: imageView.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        imageView.image = processedImage
    }
    
    
    func setBlurBackGround(set:Bool){
        if set{
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth,
                                               .flexibleHeight]
            view.addSubview(blurEffectView)
        }else{
            for subView in view.subviews{
                if subView is UIVisualEffectView{
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    func setNotificationForEmptyCells(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notifyIfCellIsEmpty),
                                               name: NSNotification.Name(rawValue: "EmptyCell"),
                                               object: nil)
    }
    
    @objc func notifyIfCellIsEmpty(){
        
    }
    
    func getWeatherData(){
        weatherViewModel.getCurrentWeather(){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.dashBoardCollectionView
                        .collectionViewLayout
                        .invalidateLayout()
                }
            }
        }
    }

    
}

