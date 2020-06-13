
//
//  CovidAPI.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/7/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation
public class Covid{
    public var newConfirmed:Int?
    public var totalConfirmed:Int?
    public var newDeaths:Int?
    public var totalDeaths:Int?
    public var newRecovered:Int?
    public var totalRecovered:Int?
    
    init(newConfirmed:Int,
         totalConfirmed:Int,
         newDeaths:Int,
         totalDeaths:Int,
         newRecovered:Int,
         totalRecovered:Int) {
        
        self.newConfirmed = newConfirmed
        self.totalConfirmed = totalConfirmed
        self.newDeaths = newDeaths
        self.totalDeaths = totalDeaths
        self.newRecovered = newRecovered
        self.totalRecovered = totalRecovered
    }
}
