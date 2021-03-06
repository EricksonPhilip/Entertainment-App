//
//  NewsViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/10/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var _view:NewsPreLoaderView? = nil
    
    lazy var tableView:UITableView = {
        let tblView = UITableView(frame: .zero)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
        tblView.tableFooterView = UIView()
        _view = NewsPreLoaderView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        tblView.backgroundView = _view
        tblView.separatorStyle = .none
        tblView.showsVerticalScrollIndicator = false
        return tblView
    }()
    
    private var viewModel:NewsViewModel = NewsViewModel()

    var currentlySelectedCellIndexPath: IndexPath?
    
    var fullNewsViewController:SourceWebViewController = SourceWebViewController()
    
    var selectedImage:Int = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        setUpTableView()
        getTopHeadLines()
    }
    
    override func viewDidLayoutSubviews() {
        if let perLoader = _view{
            perLoader.gradAnimationView()
        }
    }
    
    func setUpTableView(){
        registerHeadLineCell()
        setTableViewConstraints()
    }
    
    func registerHeadLineCell(){
        tableView.register(NewsHeadLineCell.self, forCellReuseIdentifier: NewsHeadLineCell.NewsCellID)
    }
    
    func setTableViewConstraints(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func getTopHeadLines(){
        viewModel.getTopHeadLines(){[weak self] success in
            guard let this = self else{
                return
            }
            DispatchQueue.main.async {
                if success{
                    this.tableView.backgroundView = UIView()
                    this.tableView.reloadData()
                    let selectedIndexPath = IndexPath(row: this.selectedImage, section: 0)
                    this.tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
                }
            }
        }
    }
    
    @objc func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}

extension NewsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let covidView = Covid19View(frame: CGRect(x: 0, y: 0,
                                                  width: tableView.frame.size.width,
                                                  height: 130))
        return covidView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeadLineCell.NewsCellID, for: indexPath) as! NewsHeadLineCell
        let model = viewModel.model[indexPath.row]
        
        cell.delegate = self
        
        cell.populate(model: model)
        
        cell.selectionStyle = .none
        
        return cell
    
    }
}

extension NewsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}

extension NewsViewController:cellReadMoreDelegate{
    func readMoreTapped(cell: NewsHeadLineCell) {
        if let indexPath = tableView.indexPath(for: cell){
             let model = viewModel.model[indexPath.row]
            
            let storyboard = UIStoryboard(name: "EntertainmentBoard", bundle: nil)
            
            if let NewsSource = storyboard.instantiateViewController(withIdentifier: "SourceWebViewController") as? SourceWebViewController{
                NewsSource.urlString = model.newsUrl
                NewsSource.sourceTitle = model.sourceName
                
                self.present(NewsSource, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 130
    }

}
