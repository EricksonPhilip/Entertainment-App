//
//  BottomSheetView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/31/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class PopOptionsView: UIView {
    
    lazy var tableView:UITableView = {
        let tblView = UITableView(frame: .zero)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        tblView.separatorStyle = .none
        tblView.isScrollEnabled = false
        tblView.showsVerticalScrollIndicator = false
        return tblView
    }()
    
    var optionsData:[String] = [String]()
    
    public var dismissAction:((Int)->Void)?

    required init(optionsData:[String]) {
        super.init(frame:.zero)
        self.optionsData = optionsData
        tableViewConstraints()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("from View :: \(tableView.contentSize.height)")
    }
    
    func registerCell(){
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.cellID)
    }
    
    func tableViewConstraints(){
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension PopOptionsView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.cellID, for: indexPath) as! OptionsCell
        cell.populateOptions(value: optionsData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRect(origin: CGPoint.zero,
                                         size: CGSize(width: tableView.frame.width, height: 60)))
        
        hView.translatesAutoresizingMaskIntoConstraints = false
        
        hView.backgroundColor = globalColor.commonBGKColor
        
        let labelText:UILabel = UILabel(frame: hView.frame)
        labelText.textColor = .white
        labelText.text = "Options"
        labelText.textAlignment = .center
        hView.addSubview(labelText)
        
        return hView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRect(origin: CGPoint.zero,
                                         size: CGSize(width: tableView.frame.width, height: 60)))
        
        hView.translatesAutoresizingMaskIntoConstraints = false
        
        hView.backgroundColor = globalColor.commonBGKColor
        
        let cancelButton:UIButton = UIButton(frame: hView.frame)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissController(_:)), for: .touchUpInside)
        hView.addSubview(cancelButton)
        
        return hView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

extension PopOptionsView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissController(indexPath.row)
    }
    
    @objc func dismissController(_ val:Int){
        if let dismissOption = dismissAction{
            dismissOption(val)
        }
    }
}
