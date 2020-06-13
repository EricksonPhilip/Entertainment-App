//
//  CovidCellCollectionViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/7/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class CovidCell: UICollectionViewCell {
    
    static var cellID = "CovidCell"
    var viewModel:CovidViewModel = CovidViewModel()
    
   lazy var headerLabel:UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textAlignment = .center
        label.text = "Global"
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
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
        getGlobalCovidData()
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        
        contentView.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        contentView.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 10).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func getGlobalCovidData(){
        viewModel.getCovidData(){ [weak self] success , global in
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                
                let casesView = CovidView(newText: ("+" + (global.newConfirmed?.withCommas())!),
                                          totalText: global.totalConfirmed?.withCommas() ?? "",
                                          headerText: "Cases")
                casesView.translatesAutoresizingMaskIntoConstraints = false
                casesView.backgroundColor = .lightGray
                
                this.mainStackView.addArrangedSubview(casesView)
                
                let recoveredView = CovidView(newText: ("+" + (global.newRecovered?.withCommas())!),
                                              totalText: global.totalRecovered?.withCommas() ?? "",
                                              headerText: "Recovered")
                recoveredView.translatesAutoresizingMaskIntoConstraints = false
                recoveredView.backgroundColor = .systemGreen
                
                this.mainStackView.addArrangedSubview(recoveredView)
                
                let deathView = CovidView(newText: ("+" + (global.newDeaths?.withCommas())!),
                                          totalText: global.totalDeaths?.withCommas() ?? "",
                                              headerText: "Deaths")
                deathView.translatesAutoresizingMaskIntoConstraints = false
                deathView.backgroundColor = globalColor.deathRed
                
                this.mainStackView.addArrangedSubview(deathView)
                
                let covidUS = this.viewModel.model.map{$0.country = "United States of America"}
                print(covidUS)
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
