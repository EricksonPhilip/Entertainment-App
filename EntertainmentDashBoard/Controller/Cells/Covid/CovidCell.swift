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
    
    lazy var mainStackView:UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis  = .horizontal
        view.distribution = .fillProportionally
        return view
    }()
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
        getCovidData()
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        contentView.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func getCovidData(){
        viewModel.getCovidData(){ [weak self] success , global in
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                let casesView = CovidView(newText: String(describing:global.newConfirmed ?? .zero),
                                          totalText: String(describing:global.totalConfirmed ?? .zero),
                                          headerText: "Cases")
                casesView.translatesAutoresizingMaskIntoConstraints = false
                
                this.mainStackView.addArrangedSubview(casesView)
                
                let recoveredView = CovidView(newText: String(describing:global.newRecovered ?? .zero),
                                              totalText: String(describing:global.totalRecovered ?? .zero),
                                              headerText: "Recovered")
                recoveredView.translatesAutoresizingMaskIntoConstraints = false
                
                this.mainStackView.addArrangedSubview(recoveredView)
                
                let deathView = CovidView(newText: String(describing:global.newDeaths ?? .zero),
                                          totalText: String(describing:global.totalDeaths ?? .zero),
                                              headerText: "Deaths")
                deathView.translatesAutoresizingMaskIntoConstraints = false
                
                this.mainStackView.addArrangedSubview(deathView)
            }
        }
    }
}
