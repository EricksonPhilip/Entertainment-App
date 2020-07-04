//
//  CovidCellCollectionViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/7/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class Covid19View: UIView {
    
    static var cellID = "CovidCell"
    var viewModel:CovidViewModel = CovidViewModel()
    
    var globalCovidData:Covid?
    
   lazy var headerLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textAlignment = .center
        label.text = "COVID-19 Stat (Global)"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainStackView:UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis  = .horizontal
        view.spacing = 5
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var segmentedControl:UISegmentedControl = {
        let segView = UISegmentedControl(frame: .zero)
        segView.insertSegment(withTitle: "Global", at: 0, animated: true)
        segView.insertSegment(withTitle: "US", at: 1, animated: true)
        segView.translatesAutoresizingMaskIntoConstraints = false
        segView.selectedSegmentIndex = 0
        segView.addTarget(self,
                          action: #selector(getCovidData),
                          for: .valueChanged)
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segView.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segView.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segView.backgroundColor = .darkGray
        
        return segView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        getCovidData()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        
        addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,constant: 10).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        backgroundColor = globalColor.cellBackground
    }
    
    @objc func getCovidData(){
        for view in mainStackView.subviews{
            view.removeFromSuperview()
        }
        
        viewModel.getCovidData(){ [weak self] success , global in
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                
                if this.segmentedControl.selectedSegmentIndex == .zero {
                    this.globalCovidData = global
                }else{
                    this.globalCovidData = this.viewModel.model.filter{ $0.country == "United States of America" }[.zero]
                }
                
                
                if let global = this.globalCovidData{
                    let casesView = CovidView(type: .cases,
                                              newText: ("+" + (global.newConfirmed?.withCommas())!),
                                              totalText: global.totalConfirmed?.withCommas() ?? "",
                                              headerText: "Cases")
                    casesView.translatesAutoresizingMaskIntoConstraints = false
                    casesView.newLabel.textColor = .white
                    casesView.totalLabel.textColor = .white
                    casesView.backgroundColor = .darkGray
                    casesView.type = .cases
                    
                    
                    this.mainStackView.addArrangedSubview(casesView)
                    
                    let recoveredView = CovidView(type: .recovered,
                                                  newText: ("+" + (global.newRecovered?.withCommas())!),
                                                  totalText: global.totalRecovered?.withCommas() ?? "",
                                                  headerText: "Recovered")
                    recoveredView.translatesAutoresizingMaskIntoConstraints = false
                    recoveredView.newLabel.textColor = .white
                    recoveredView.totalLabel.textColor = .white
                    recoveredView.backgroundColor = globalColor.drecoveredGreen
                    
                    this.mainStackView.addArrangedSubview(recoveredView)
                    
                    let deathView = CovidView(type: .deaths,
                                              newText: ("+" + (global.newDeaths?.withCommas())!),
                                              totalText: global.totalDeaths?.withCommas() ?? "",
                                                  headerText: "Deaths")
                    deathView.translatesAutoresizingMaskIntoConstraints = false
                    deathView.backgroundColor = globalColor.deathRed
                    deathView.newLabel.textColor = .white
                    deathView.totalLabel.textColor = .white
                    
                    this.mainStackView.addArrangedSubview(deathView)
                }
            }
        }
    }

}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
