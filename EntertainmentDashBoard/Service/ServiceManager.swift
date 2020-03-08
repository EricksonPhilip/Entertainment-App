//
//  ServiceManager.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation

class ServiceManager {
    
    /// Get Movies test
    func MovieServicesGET(STRURL:String,completion :@escaping ([String:AnyObject]?, NSError?) -> ()){
        
        let Str_url = STRURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string:Str_url){
            
            var Movies_Req_URL = URLRequest(url: url)
            
            Movies_Req_URL.httpMethod = "GET"
            
            let Movies_Task = URLSession.shared.dataTask(with: Movies_Req_URL){data,response,error in
                
                guard let Matches_data = data ,error == nil else {
                    print("error=\(String(describing: error))")//Network Error
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse,
                    httpStatus.statusCode != 200 {   // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                do{
                    let matchesDict = try (JSONSerialization.jsonObject(with: Matches_data, options: [])as?[String:AnyObject])!
                    
                    print(matchesDict as Any)
                    
                    completion(matchesDict,nil)
                }
                catch{}
            }
            
            Movies_Task.resume()
        }
        
        
    }
    
    //Output as [AnyObject]
    func MoviesServicesGET(STRURL:String,completion :@escaping ([AnyObject]?, NSError?) -> ()){
        
        if let url = URL(string:STRURL){
            
            var Movies_Req_URL = URLRequest(url: url)
            
            Movies_Req_URL.httpMethod = "GET"
            
            let Movies_Task = URLSession.shared.dataTask(with: Movies_Req_URL){data,response,error in
                
                guard let Movies_data = data ,error == nil else {
                    
                    print("error=\(String(describing: error))")//Network Error
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {   // check for http errors
                    
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                do{
                    
                    let Movies_Dict = try JSONSerialization.jsonObject(with: Movies_data, options: [])as?[AnyObject]
                    
                    print(Movies_Dict as Any)
                    
                    completion(Movies_Dict,nil)
                }
                catch{
                    
                }
            }
            
            Movies_Task.resume()
        }
    }
    
    func servicesGET(STRURL: String,completion :@escaping ([String:AnyObject]?, NSError?) -> ()){
        
        var reqURL = URLRequest(url: URL(string: STRURL)!)
        
        reqURL.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: reqURL){data,response,error in
            
            guard let _data = data ,error == nil else {
                print("error=\(String(describing: error))")//Network Error
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {   // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            do{
                let Dict = try JSONSerialization.jsonObject(with: _data, options: [])as?[String:AnyObject]
                
                print(Dict as Any)
                
                completion(Dict,nil)
            }
            catch{}
            
        }
        
        task.resume()
        
    }
    
    func CricketServicesGET(STRURL: String,completion :@escaping ([String:AnyObject]?, NSError?) -> ()){
        
        var cricketReqURL = URLRequest(url: URL(string: STRURL)!)
        
        cricketReqURL.httpMethod = "GET"
        
        let cricketTask = URLSession.shared.dataTask(with: cricketReqURL){data,response,error in
            
            guard let Matches_data = data ,error == nil else {
                print("error=\(String(describing: error))")//Network Error
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {   // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            do{
                let cricketDict = try JSONSerialization.jsonObject(with: Matches_data, options: [])as?[String:AnyObject]
                
                print(cricketDict as Any)
                
                completion(cricketDict,nil)
            }
            catch{
                
            }
        }
        
        cricketTask.resume()
        
    }
}
