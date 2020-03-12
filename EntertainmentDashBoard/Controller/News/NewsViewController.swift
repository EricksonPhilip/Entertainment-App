//
//  NewsViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/10/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tblView = UITableView(frame: .zero)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
        tblView.tableFooterView = UIView()

        return tblView
    }()
    
    private var viewModel:NewsViewModel = NewsViewModel()

    var currentlySelectedCellIndexPath: IndexPath?
    
    var fullNewsViewController:SourceWebViewController = SourceWebViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getTopHeadLines()
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
            guard let strongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                if success{
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }

}

extension NewsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeadLineCell.NewsCellID, for: indexPath) as! NewsHeadLineCell
        let model = viewModel.model[indexPath.row]
        
        cell.delegate = self
        
        cell.populate(model: model)
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(origin: CGPoint.zero,
                                              size: CGSize(width: tableView.frame.width,
                                                           height: 60)))
        
        let closeButton = UIButton(frame: .zero)
        let closeImage = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(closeButton)
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        
        headerView.backgroundColor = .darkGray

        let label = UILabel()
        label.frame = CGRect(x: 5, y: 5,
                             width: headerView.frame.width-10,
                             height: headerView.frame.height-10)
        label.text = "News"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white

        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension NewsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension NewsViewController:cellReadMoreDelegate{
    func readMoreTapped(cell: NewsHeadLineCell) {
        if let indexPath = tableView.indexPath(for: cell){
             let model = viewModel.model[indexPath.row]
            
            //fullNewsViewController.urlString = model.newsUrl
            
            let storyboard = UIStoryboard(name: "EntertainmentBoard", bundle: nil)
            let NewsSource = storyboard.instantiateViewController(withIdentifier: "SourceWebViewController") as! SourceWebViewController
            
            NewsSource.urlString = model.newsUrl
            NewsSource.sourceTitle = model.sourceName
            
            self.present(NewsSource, animated: true, completion: nil)
        }
    }

}
