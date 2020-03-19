//
//  DashBoardCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var postureImageView: UIImageView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextPreviousButton: UIButton!
    @IBOutlet weak var labelCurrentPageNo: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var movieTypeListLabel: UILabel!
    
    var movieTypeList:[MovieTypeList] = [MovieTypeList]()
    
    var currPageNo:Int = 1
        
    var viewModel:MoviesViewModel = MoviesViewModel()
    
    let view:UIWindow = UIWindow()
    
    
    override func awakeFromNib() {
        registerCells()
        setSizingCellsForCollectionView()
        getNumberOfPopularMovies(pageNo: 1)
        setCollectionView()
        styleDropDownview()
        makeDropDownClickable()
        setMovieTypeList()
        setNotificationForClosing()
    }
    
    func setCollectionView(){
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        self.pageControl.currentPage = 0
    }
    
    func registerCells(){
        movieCollectionView.register(UINib(nibName: "MovieListCell",
                                           bundle: nil),
                                    forCellWithReuseIdentifier: "MovieList")
    }
    
    func setSizingCellsForCollectionView(){
        if let flowLayout = movieCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = movieCollectionView {
            
            let w = self.bounds.width
            flowLayout.minimumLineSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: w, height: 400)
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    

    func styleDropDownview(){
        dropDownView.layer.addBorder(edge: [.top,.left,
                                            .right,.bottom], color: UIColor.black, thickness: 0.5)
        dropDownView.roundCorners(corners: [.allCorners],
                                  radius: 10)
    }
    
    func setMovieTypeList(){
        movieTypeList.append(.popular)
        movieTypeList.append(.latest)
        movieTypeList.append(.nowPlaying)
        movieTypeList.append(.topRated)
        movieTypeList.append(.upcoming)
    }
    
    func showPopUpMenu(){
//        let popMenuManager = PopMenuManager.default
//        popMenuManager.popMenuDelegate = self
//        popMenuManager.popMenuAppearance.popMenuColor = .configure(background: .solid(fill: UIColor.white),
//                                                                   action: .tint(UIColor.black))
//        popMenuManager.popMenuAppearance.popMenuPresentationStyle = .cover()
//
//        popMenuManager.actions = [
//            PopMenuDefaultAction(title: movieTypeList[0].rawValue),
//            PopMenuDefaultAction(title: movieTypeList[1].rawValue),
//            PopMenuDefaultAction(title: movieTypeList[2].rawValue),
//            PopMenuDefaultAction(title: movieTypeList[3].rawValue),
//            PopMenuDefaultAction(title: movieTypeList[4].rawValue)
//        ]
//
//        popMenuManager.present(sourceView: dropDownView)
    }
    
    func makeDropDownClickable(){
        
        let dropDowntap = UITapGestureRecognizer(target: self,
                                                 action: #selector(dropDownTapped(sender:)))
        dropDownView.addGestureRecognizer(dropDowntap)
    }
    

    @objc
    func dropDownTapped(sender: UITapGestureRecognizer) {
        showPopUpMenu()
    }
    
    func populate(model:MoviesPostureModel){
        postureImageView.layer.cornerRadius = self.frame.size.width/2
        setPostureImage(url: model.posterPath)
    }
    
    func setPostureImage(url:String){
        let fullUrl = moviePosterBaseUrl + url
        let _url = URL(string: fullUrl)
        
        postureImageView.sd_setImage(with: _url,
                                     placeholderImage: defaultMovieImage,
                                     options: .continueInBackground)
    }
    
    func refreshCollectionView(){
        self.pageControl.numberOfPages = self.viewModel.numberOfPostures()
        self.movieCollectionView.reloadData()
    }
    
    
    //MARK:Get Type Of Movies List
    func getNumberOfPopularMovies(pageNo:Int){
        viewModel.getPopularMoviesPostures(pageNo: String(currPageNo)){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.refreshCollectionView()
                }
                
            }
        }
    }
    
    func getTopRated(pageNo:Int){
        viewModel.getTopRatedMovies(pageNo: String(currPageNo)){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.refreshCollectionView()
                }
            }
        }
    }
    
    func getLatestMovies(){
        viewModel.getLatestMovies{[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.refreshCollectionView()
                }
            }
        }
    }
    
    func getUpcomingMovies(pageNo:Int){
        viewModel.getUpcomingMovies(pageNo:String(pageNo)){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.refreshCollectionView()
                }
            }
        }
    }
    
    func getNowPlayingMovies(pageNo:Int){
        viewModel.getNowPlaying(pageNo:String(pageNo)){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.pageControl.numberOfPages = self!.viewModel.numberOfPostures()
                    self!.movieCollectionView.reloadData()
                }
            }
        }
    }
    
    func setNotificationForClosing(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onDidReceiveData(_:)),
                                               name: NSNotification.Name(rawValue: "RemoveBlur"),
                                               object: nil)
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            //setBlurBackGround(set: false,this: topController)
        }
       
    }
    
    func scrollCellsToFirstIndex(){
        movieCollectionView.scrollToItem(
            at: NSIndexPath(item: 0,
                            section: 0) as IndexPath,
            at: [],
            animated: true)
    }
    
    func reset(){
        viewModel = MoviesViewModel()
        self.pageControl.currentPage = 0
    }
    
    func nextPreviousAction(type:String){
        let typeList = MovieTypeList(rawValue: type)
        
        switch typeList {
        case .popular?:
            getNumberOfPopularMovies(pageNo: currPageNo)
        case .topRated?:
            getTopRated(pageNo: currPageNo)
        case .latest?:
            getLatestMovies()
        case .upcoming?:
            getUpcomingMovies(pageNo: currPageNo)
        case .nowPlaying?:
            getNowPlayingMovies(pageNo: currPageNo)
        default:
            getNumberOfPopularMovies(pageNo: currPageNo)
        }
    }
    
    func setBlurBackGround(set:Bool,this:UIViewController){
        
        if set{
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = this.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth,
                                               .flexibleHeight]
            this.view.addSubview(blurEffectView)
        }else{
            for subView in this.view.subviews{
                if subView is UIVisualEffectView{
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        reset()
        currPageNo = currPageNo <= 0 ? 1 :  currPageNo - 1
        
        labelCurrentPageNo.text = String(currPageNo)
        scrollCellsToFirstIndex()
        nextPreviousAction(type: movieTypeListLabel.text!)

    }
    @IBAction func nextPageAction(_ sender: Any) {
        reset()
        currPageNo = currPageNo + 1
        
        labelCurrentPageNo.text = String(currPageNo)
        scrollCellsToFirstIndex()
        nextPreviousAction(type: movieTypeListLabel.text!)
    }
    
    @IBAction func listMovieSections(_ sender: Any) {
        showPopUpMenu()
    }
}

extension MovieCell:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(movieCollectionView .bounds.size.width + 10)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(movieCollectionView!.contentSize.width)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        }else{
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            newPage = newPage < 0 ? 0 : newPage
            newPage = newPage > contentWidth / pageWidth ? ceil(contentWidth / pageWidth) - 1.0 : newPage
        }
        
        self.pageControl.currentPage = Int(newPage) %  self.viewModel.numberOfPostures() //defaultNumberOfPages
        let point = CGPoint (x: CGFloat(newPage * pageWidth),
                             y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        print("Current Page :: \(newPage)")
        
    }
}

extension MovieCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPostures()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieList",
                                                         for: indexPath) as! MovieListCell
        let model = viewModel.model[indexPath.row]
        movieListCell.populate(model: model)
        return movieListCell
    }
}

extension MovieCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let postureModel = viewModel.model[indexPath.row]
        
        let entSB = UIStoryboard.init(name: "EntertainmentBoard", bundle: nil)
        
        let ViewMovieDetail = entSB.instantiateViewController(withIdentifier: "ViewScore") as! ViewMovieController
        
        ViewMovieDetail.modalPresentationStyle = UIModalPresentationStyle.custom
        ViewMovieDetail.transitioningDelegate = self
        
        ViewMovieDetail.view.backgroundColor = UIColor.clear
        
        ViewMovieDetail.postureURL = postureModel.posterPath
        ViewMovieDetail.movieName = postureModel.movieName
        ViewMovieDetail.movieOverView = postureModel.movieOverView
        ViewMovieDetail.backDropUrl = postureModel.backDropPath
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            //setBlurBackGround(set: true,this: topController)
            
            topController.present(ViewMovieDetail, animated: false, completion: nil)
        }
        
        
        
        //self.present(ViewScore, animated: true, completion: nil)
    }
}
extension MovieCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 400)
    }
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let cellWidth: CGFloat = collectionView.bounds.size.width // Your cell width
        
        let numberOfCells = floor(self.bounds.width / cellWidth)
        let edgeInsets = (self.bounds.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets )
    }
}

extension MovieCell:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
