//
//  WeatherModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
struct WeatherModel{
    let weatherId:Int!
    let cityName:String!
    let temp:Float!
    let desc:String!
    let imageUrl:String!
    let cod:Int!
    
    init(weatherId:Int,
         cityName:String,
         temp:Float,
         desc:String,
         imageUrl:String,
         cod:Int) {
        self.weatherId = weatherId
        self.cityName = cityName
        self.temp = temp
        self.desc = desc
        self.imageUrl = imageUrl
        self.cod = cod
    }
}
