
//
//  popularTVModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/8/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
struct PopularTVModel{
    let tvId:Int!
    let name:String!
    let backDropPath:String!
    let posturePath:String!
    
    init(tvId:Int,
         name:String,
         backDropPath:String,
         posturePath:String) {
        
        self.tvId = tvId
        self.name = name
        self.backDropPath = backDropPath
        self.posturePath = posturePath
    }
    
}
