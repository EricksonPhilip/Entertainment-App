//
//  DashMatchedCellCollectionViewCell.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 4/5/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class CricketMatchesView: UIView {
    lazy var vStackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var teamOneLabel:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Team One"
        label.textColor = .white
        return label
    }()
    
    lazy var vsLabel:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "VS"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var teamTwoLabel:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Team Two"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var matchTypeLabel:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Match Type"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var scoreLabel:UILabel = {
        let label:UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score Label"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        backgroundColor = globalColor.alertControllerBackground
        setStackViewConstraints()
    }
    
    func setStackViewConstraints(){
        addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addLabelsToStackView()
        
    }
    
    func addLabelsToStackView(){
        vStackView.addArrangedSubview(teamOneLabel)
        vStackView.addArrangedSubview(vsLabel)
        vStackView.addArrangedSubview(teamTwoLabel)
        vStackView.addArrangedSubview(matchTypeLabel)
        vStackView.addArrangedSubview(scoreLabel)
    }
    
    func populate(model:CricketModel){
        teamOneLabel.text = model.team1
        teamTwoLabel.text = model.team2
        matchTypeLabel.text = model.matchType
        scoreLabel.text = model.Score
    }
}
