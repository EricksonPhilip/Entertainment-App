//
//  PopularTvViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/8/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
class PopularTvViewModel {
    
    var model:[PopularTVModel] = [PopularTVModel]()
    let tvServices = ServiceManager()
    
    func getPopularTvShows(completed:@escaping (Bool) -> ()){
        tvServices.servicesGET(STRURL: popularTVUrl){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let popularTvArray = response!["results"]
            
            for show in popularTvArray as! [AnyObject] {
                
                let id    = show["id"] as! Int
                let name = show["original_name"] as? String ?? "Movie Name"
                let backDropUrl = show["backdrop_path"] as? String ?? "https://"
                let postureUrl = show["poster_path"] as? String ?? "https://"
                
                let showModel = PopularTVModel(tvId: id,
                                               name: name,
                                               backDropPath: backDropUrl,
                                               posturePath: postureUrl)
                
                self.model.append(showModel)
                
            }
            
            completed(true)
        }
    }
    
    func numberOfTvShows() -> Int{
        return model.count
    }
}
