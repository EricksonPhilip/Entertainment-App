//
//  MusicViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 3/1/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import Foundation
class MusicViewModel{
    var model:[MusicArtistsModel] = [MusicArtistsModel]()
    let topArtistServices = ServiceManager()
    
    func getTopArtists(completed:@escaping (Bool) -> ()){
        
        topArtistServices.servicesGET(STRURL: musicTopArtistUrl){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let allArtists = response!["artists"]
            let artists = allArtists!["artist"]
            
            for artist in artists as! [AnyObject] {
                
                let id = artist["mbid"] as! String
                let name = artist["name"] as? String ?? "No Name"
                let artistUrl = artist["url"] as? String ?? "NIL"
                let image = artist["image"] as? [AnyObject]
                
                let imageSize = image![2] as! [String:String]
                
                let imageUrl = imageSize["#text"]
                
                
                let topArtistModel = MusicArtistsModel(musicId: id,
                                                artistName: name,
                                                artistUrl: artistUrl, imageUrl: imageUrl!)
                self.model.append(topArtistModel)
                
            }
            
            completed(true)
        }
    }
    
    func numberOfArtists() -> Int{
        return self.model.count
    }
}

class TopTracksViewModel{
    var model:[MusicTopTracksModel] = [MusicTopTracksModel]()
    let topTracksServices = ServiceManager()
    
    func getTopTracks(completed:@escaping (Bool) -> ()){
        
        topTracksServices.servicesGET(STRURL: musicTopTracksUrl){
            response,error in
            
            guard response != nil && error == nil else {
                return
            }
            
            let allTracks = response!["tracks"]
            let tracks = allTracks!["track"]
            
            for track in tracks as! [AnyObject] {
                
                let name = track["name"] as? String ?? "No Name"
                let trackUrl = track["url"] as? String ?? "NIL"
                
                let image = track["image"] as? [AnyObject]
                let imageSize = image![2] as! [String:String]
                
                let trackimageUrl = imageSize["#text"]
                
                let artist = track["artist"] as? [String:AnyObject]
          
                let artistId = artist!["mbid"] as? String ?? "NA"
                let artistName = artist!["name"] as? String ?? "Name"
                let artistUrl = artist!["url"] as? String ?? "N/A"
                
                let artistModel = MusicArtistsModel(musicId: artistId,
                                                    artistName: artistName,
                                                    artistUrl: artistUrl,
                                                    imageUrl: "")
                
                let topTrackModel = MusicTopTracksModel(trackName: name,
                                                        trackImageUrl: trackimageUrl!,
                                                        trackUrl: trackUrl,
                                                        artist: artistModel)
                self.model.append(topTrackModel)
                
            }
            
            completed(true)
        }
    }
    
    func numberOfTracks() -> Int{
        return self.model.count
    }
}
