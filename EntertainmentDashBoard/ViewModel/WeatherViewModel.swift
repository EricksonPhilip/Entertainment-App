//
//  WeatherViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/21/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
class WeatherViewModel{
    
    var model:WeatherModel?
    let weatherManager = ServiceManager()
    let convert = utilities()
    
    func getCurrentWeather(completed:@escaping (Bool) -> ()){
    
        weatherManager.servicesGET(STRURL: currentWeatherUrl){
            data,error in
            
            guard data != nil && error == nil else {
                return
            }
            
            let weatid = data?["id"] as? Int ?? 0
            let cityName = data?["name"] as? String ?? "NIL"
            let weather = data?["weather"]
            let main = data?["main"] as? [String : Any]

            let tempData = main!["temp"] as? Double ?? 0.0
            
            
            let tempVal = self.convert.kelvinToFahrenheit(value: Float(tempData))
            
            let weatherData = weather![0] as! [String:Any]
            let desc = weatherData["description"] as? String ?? "NIL"
            let icn = weatherData["icon"] as? String ?? "NIL"
            let iconUrl = weatherBaseImageUrl + icn + ".png"
            let cod = data?["cod"] as? Int ?? 0
            
            let model = WeatherModel(weatherId: weatid,
                                     cityName: cityName,
                                     temp: tempVal,
                                     desc: desc, imageUrl: iconUrl, cod: cod)
            
            self.model = model
            
            completed(true)
            
        }
    }
    
}

