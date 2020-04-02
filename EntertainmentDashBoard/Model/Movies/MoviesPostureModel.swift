//
//  MovieModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
struct MoviesPostureModel{
    let movieId:Int!
    let movieName:String!
    let movieOverView:String!
    let posterPath:String!
    let backDropPath:String!
    let voteAvg:Float!
    
    init(movieId:Int,
         posterPath:String,
         movieName:String,
         movieOverView:String,
         backDropPath:String,
         voteAvg:Float){
        
        self.movieId = movieId
        self.movieName = movieName
        self.posterPath = posterPath
        self.movieOverView = movieOverView
        self.backDropPath = backDropPath
        self.voteAvg = voteAvg
    }
}
