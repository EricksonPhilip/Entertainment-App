//
//  PopUpViewControllerTViewController.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/31/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tblView = UITableView(frame: .zero)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .singleLine
        tblView.separatorColor = .white
        tblView.separatorInset = UIEdgeInsets.zero
        tblView.showsVerticalScrollIndicator = false
        return tblView
    }()
   
    var arrayOptions:[String] = [String]()
    
    var tableViewHeightConst:NSLayoutConstraint?
    
    var didTappedAction:((MovieTypeList)->Void)?
        
    var rowHeight:CGFloat{
        return 60
    }
    
    var footerHeight:CGFloat{
        return 50
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        setUpOptionsView()
        registerCell()

    }
    
    func registerCell(){
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.cellID)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        tableViewHeightConst?.constant = tableView.contentSize.height + 85
    }
   
    func setUpOptionsView(){
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableViewHeightConst = tableView.heightAnchor.constraint(equalToConstant: 50)
        tableViewHeightConst?.isActive = true
    }

}

extension PopUpViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.cellID, for: indexPath) as! OptionsCell
        cell.populateOptions(value: arrayOptions[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRect(origin: CGPoint.zero,
                                         size: CGSize(width: tableView.frame.width, height: 60)))
        
        hView.backgroundColor = globalColor.commonBGKColor
        
        let cancelButton:UIButton = UIButton(frame: hView.frame)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        //cancelButton.addTarget(self, action: #selector(dismissController(_:)), for: .touchUpInside)
        hView.addSubview(cancelButton)
        
        return hView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
}

extension PopUpViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        var variant:MovieTypeList = .nowPlaying
        
        switch row{
        case 0:
            variant = .popular
        case 1:
            variant = .topRated
        case 2:
            variant = .nowPlaying
        case 3:
            variant = .upcoming
        case 4:
            variant = .latest
        default:
            variant = .nowPlaying
        }
        
        handleTappedAction(variant)
    }
    
    func handleTappedAction(_ variant:MovieTypeList){
        if let tappedOption = didTappedAction{
            tappedOption(variant)
        }
    }
}
