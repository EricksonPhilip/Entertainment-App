//
//  NewsModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
struct NewsModel {
    let newsId:String?
    let newsUrl:String?
    let newsImageUrl:String?
    let sourceName:String?
    let newsTitle:String?
    let newsDesc:String?
    let newsContent:String?
    let newsUrlImage:String?
    
    init(newsId:String,
         newsUrl:String,
         newsImageUrl:String,
         sourceName:String,
         newsTitle:String,
         newsDesc:String,
         newsContent:String,
         newsUrlImage:String) {
        
        self.newsId = newsId
        self.newsUrl = newsUrl
        self.newsImageUrl = newsImageUrl
        self.sourceName = sourceName
        self.newsTitle = newsTitle
        self.newsDesc = newsDesc
        self.newsContent = newsContent
        self.newsUrlImage = newsUrlImage
    }
}
