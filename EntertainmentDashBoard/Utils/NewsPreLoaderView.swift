//
//  NewsPreLoaderView.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 3/12/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import UIKit

class NewsPreLoaderView: UIView {
    
    var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    
    lazy var vStackView:UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    lazy var preTitleView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var preTitleView1:UIView = {
           let view = UIView(frame: .zero)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .lightGray
           return view
       }()
    
    lazy var preImageView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var preImageView1:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var preDescView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var preDescView1:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        setStackViewConstraints()
        addViewsToStackView()
    }
    
    func setStackViewConstraints(){
        addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: topAnchor,constant:70).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
    }
    
    func addViewsToStackView(){
        vStackView.addArrangedSubview(preTitleView)
        preTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        vStackView.addArrangedSubview(preImageView)
        preImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        vStackView.addArrangedSubview(preDescView)
        preDescView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        vStackView.addArrangedSubview(preTitleView1)
        preTitleView1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        vStackView.addArrangedSubview(preImageView1)
        preImageView1.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        vStackView.addArrangedSubview(preDescView1)
        preDescView1.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func gradAnimationView(){
        setGradientsAndAnimate(view: preTitleView)
        setGradientsAndAnimate(view: preImageView)
        setGradientsAndAnimate(view: preDescView)
        setGradientsAndAnimate(view: preTitleView1)
        setGradientsAndAnimate(view: preImageView1)
        setGradientsAndAnimate(view: preDescView1)
    }
    
    func setGradientsAndAnimate(view:UIView){
        let gradient = CAGradientLayer(layer: view.layer)
        gradient.colors = [gradientColorOne,gradientColorTwo,gradientColorOne]
        gradient.locations = [0.0,0.5,1.0]
        gradient.startPoint = CGPoint(x: 0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1, y: 1.0)
        gradient.frame = view.bounds
        
        view.layer.insertSublayer(gradient, at: 0)
        
        let anime = CABasicAnimation(keyPath: "locations")
        anime.duration = 1.3
        anime.fromValue = [-1.0, -0.5, 0.0]
        anime.toValue = [1.0, 1.5, 2.0]
        anime.repeatCount = Float.infinity
        gradient.add(anime, forKey: nil)

    }
    
    func stopAnimation(){
        preTitleView.layer.removeAllAnimations()
        preImageView.layer.removeAllAnimations()
        preDescView.layer.removeAllAnimations()
        
        preTitleView1.layer.removeAllAnimations()
        preImageView1.layer.removeAllAnimations()
        preDescView1.layer.removeAllAnimations()
    }
    
}
