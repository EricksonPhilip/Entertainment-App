//
//  DashBoardList.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
public enum DashBoardList{
    case cricket
    case movies
    case tv
    case music
    case weather
    case news
    
    
    static let lists = [cricket, movies, tv,music,weather,news]
}

public enum MovieTypeList:String{
    case popular = "Popular"
    case latest = "Latest"
    case topRated = "Top Rated"
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    
    
    static let lists:[String] = [popular.rawValue, topRated.rawValue, nowPlaying.rawValue,upcoming.rawValue,latest.rawValue]
    
    func get()->String{
        switch self {
        case .popular:
            return "Popular"
        case .latest:
            return "latest"
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"

        }
    }

}
