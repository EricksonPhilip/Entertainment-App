//
//  NewsViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/6/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
class NewsViewModel{
    var model:[NewsModel] = [NewsModel]()
    let newsServices = ServiceManager()
    
    
    func getTopHeadLines(completed:@escaping (Bool) -> ()){
        newsServices.servicesGET(STRURL: topHeadLinesURL){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let newsTempArray = response!["articles"]
            
            for news in newsTempArray as! [AnyObject] {
                
                let source    = news["source"] as? [String:String]
                let newsId    = source?["id"] ?? "NIL"
                let sourceName = source?["name"] ?? "News"
                let newsUrl   = news["url"] as! String
                let newsImageUrl = news["urlToImage"] as? String ?? "Nil"
                let newsTitle = news["title"] as! String
                let newsDesc  = news["description"] as? String ?? "Description Not availble"
                let newsContent = news["content"] as? String ?? "Content not available"
                let newUrlImage = news["urlToImage"] as? String ?? ""
                
                let newsModel = NewsModel(newsId: newsId,
                                          newsUrl: newsUrl,
                                          newsImageUrl:newsImageUrl,
                                          sourceName: sourceName,
                                          newsTitle: newsTitle,
                                          newsDesc: newsDesc,
                                          newsContent: newsContent,
                                          newsUrlImage:newUrlImage)
                
                self.model.append(newsModel)
                
            }
            
            completed(true)
        }
    }
    
    func numberOfNews()->Int{
        return self.model.count
    }
}
