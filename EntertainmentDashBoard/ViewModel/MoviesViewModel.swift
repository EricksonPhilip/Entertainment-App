//
//  MoviesViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/7/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
class MoviesViewModel{
    var model:[MoviesPostureModel] = [MoviesPostureModel]()
    let moviesPostureServices = ServiceManager()
    
    func getPopularMoviesPostures(pageNo:String,completed:@escaping (Bool) -> ()){
        
        moviesPostureServices.servicesGET(STRURL: moviesPopularUrl + pageNo){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let posturesTempArray = response!["results"]
            
            for posture in posturesTempArray as! [AnyObject] {
                
                let id = posture["id"] as! Int
                let postureUrl = posture["poster_path"] as? String ?? "NIL"
                let backDropUrl = posture["backdrop_path"] as? String ?? "NIL"
                let name = posture["original_title"] as? String ?? "NR"
                let movieOverView = posture["overview"] as? String ?? "NIL"
                
                let postureModel = MoviesPostureModel(movieId: id,
                                                      posterPath: postureUrl,
                                                      movieName: name,
                                                      movieOverView: movieOverView,
                                                      backDropPath: backDropUrl,
                                                      voteAvg: .zero)
                
                self.model.append(postureModel)
                
            }
            
            completed(true)
        }
    }
    
    func getLatestMovies(completed:@escaping (Bool) -> ()){
        moviesPostureServices.servicesGET(STRURL: moviesLatestUrl){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let id = response!["id"] as! Int
            let postureUrl = response!["poster_path"] as? String ?? "NIL"
            let backDropUrl = response!["backdrop_path"] as? String ?? "NIL"
            let name = response!["original_title"] as? String ?? "NR"
            let movieOverView = response!["overview"] as? String ?? "NIL"
            
            let postureModel = MoviesPostureModel(movieId: id,
                                                  posterPath: postureUrl,
                                                  movieName: name,
                                                  movieOverView: movieOverView,
                                                  backDropPath: backDropUrl,
                                                  voteAvg: .zero)
            
            self.model.append(postureModel)            
            completed(true)
        }
    }
    
    func getTopRatedMovies(pageNo:String,completed:@escaping (Bool) -> ()){
        moviesPostureServices.servicesGET(STRURL: moviesTopRatedUrl + pageNo){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let posturesTempArray = response!["results"]
            
            for posture in posturesTempArray as! [AnyObject] {
                
                let id = posture["id"] as! Int
                let postureUrl = posture["poster_path"] as? String ?? "NIL"
                let backDropUrl = posture["backdrop_path"] as? String ?? "NIL"
                let name = posture["original_title"] as? String ?? "NR"
                let movieOverView = posture["overview"] as? String ?? "NIL"
                
                let postureModel = MoviesPostureModel(movieId: id,
                                                      posterPath: postureUrl,
                                                      movieName: name,
                                                      movieOverView: movieOverView,
                                                      backDropPath: backDropUrl,
                                                      voteAvg: .zero)
                
                self.model.append(postureModel)
                
            }
            
            completed(true)
        }
    }
    
    func getNowPlaying(pageNo:String,completed:@escaping (Int) -> ()){
        moviesPostureServices.servicesGET(STRURL: moviesNowPlayingUrl + pageNo){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let posturesTempArray = response!["results"]
            
            let numberOfPages = response!["total_pages"] as! Int
            
            for posture in posturesTempArray as! [AnyObject] {
                
                let id = posture["id"] as! Int
                let postureUrl = posture["poster_path"] as? String ?? "NIL"
                let backDropUrl = posture["backdrop_path"] as? String ?? "NIL"
                let name = posture["original_title"] as? String ?? "NR"
                let movieOverView = posture["overview"] as? String ?? "NIL"
                let movieRating = posture["vote_average"] as? Float ?? 0.0
                
                let postureModel = MoviesPostureModel(movieId: id,
                                                      posterPath: postureUrl,
                                                      movieName: name,
                                                      movieOverView: movieOverView,
                                                      backDropPath: backDropUrl,
                                                      voteAvg: movieRating)
                
                self.model.append(postureModel)
                
            }
            
            completed(numberOfPages)
        }
    }
    
    func getUpcomingMovies(pageNo:String,completed:@escaping (Bool) -> ()){
        moviesPostureServices.servicesGET(STRURL: moviesUpcomingUrl + pageNo){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let posturesTempArray = response!["results"]
            
            for posture in posturesTempArray as! [AnyObject] {
                
                let id = posture["id"] as! Int
                let postureUrl = posture["poster_path"] as? String ?? "NIL"
                let backDropUrl = posture["backdrop_path"] as? String ?? "NIL"
                let name = posture["original_title"] as? String ?? "NR"
                let movieOverView = posture["overview"] as? String ?? "NIL"
                
                let postureModel = MoviesPostureModel(movieId: id,
                                                      posterPath: postureUrl,
                                                      movieName: name,
                                                      movieOverView: movieOverView,
                                                      backDropPath: backDropUrl,
                                                      voteAvg: .zero)
                
                self.model.append(postureModel)
                
            }
            
            completed(true)
        }
    }
    
    func numberOfPostures() -> Int{
        return self.model.count
    }
    
}
