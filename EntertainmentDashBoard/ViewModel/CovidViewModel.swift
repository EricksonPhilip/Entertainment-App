//
//  CovidViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Erickson Philip on 6/7/20.
//  Copyright © 2020 Eric. All rights reserved.
//

import Foundation

class CovidViewModel{
    
    var model:[Covid] = [Covid]()
    let covidServices = ServiceManager()
    
    func getCovidData(completed:@escaping (Bool,Covid) -> ()){
        covidServices.servicesGET(STRURL: covidAPI ){
            response,error in
            
            guard response != nil && error == nil else {
                print("Response Empty")
                return
            }
            
            let date = response!["Date"]
            let countries = response!["Countries"]
            
            var globalCovid:Covid? = nil
            if let global =  response!["Global"]{
                let newConfirmed = global["NewConfirmed"] as! Int
                let totalConfirmed = global["TotalConfirmed"] as! Int
                let newDeaths = global["NewDeaths"] as! Int
                let totalDeaths = global["TotalDeaths"] as! Int
                let newRecovered = global["NewRecovered"] as! Int
                let totalRecovered = global["TotalRecovered"] as! Int
                
                globalCovid = Covid(newConfirmed: newConfirmed,
                                    totalConfirmed: totalConfirmed,
                                    newDeaths: newDeaths,
                                    totalDeaths: totalDeaths,
                                    newRecovered: newRecovered,
                                    totalRecovered: totalRecovered)
            }
            
            
            for country in countries as! [AnyObject] {
                
                let _country = country["Country"] as! String
                let date = country["Date"] as! String
                let newConfirmed = country["NewConfirmed"] as! Int
                let totalConfirmed = country["TotalConfirmed"] as! Int
                let newDeaths = country["NewDeaths"] as! Int
                let totalDeaths = country["TotalDeaths"] as! Int
                let newRecovered = country["NewRecovered"] as! Int
                let totalRecovered = country["TotalRecovered"] as! Int
                
                let covidModel = Covid(country:_country,
                                       date :date,
                                       newConfirmed: newConfirmed,
                                       totalConfirmed: totalConfirmed,
                                       newDeaths: newDeaths,
                                       totalDeaths: totalDeaths,
                                       newRecovered: newRecovered,
                                       totalRecovered: totalRecovered)
                
                self.model.append(covidModel)
            }
            
            completed(true,globalCovid!)
        }
    }
}
