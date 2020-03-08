//
//  MusicModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 3/1/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
struct MusicArtistsModel{
    let musicId:String!
    let artistName:String!
    let artistUrl:String!
    let imageUrl:String!
    
    init(musicId:String,
         artistName:String,
         artistUrl:String,
         imageUrl:String){
        
        self.musicId = musicId
        self.artistName = artistName
        self.artistUrl = artistUrl
        self.imageUrl = imageUrl
    }
}

struct MusicTopTracksModel{
    let trackName:String!
    let trackImageUrl:String!
    let trackUrl:String!
    let artist:MusicArtistsModel!
    
    init(trackName:String,
         trackImageUrl:String,
         trackUrl:String,
         artist:MusicArtistsModel) {
        self.trackName = trackName
        self.trackImageUrl = trackImageUrl
        self.trackUrl = trackUrl
        self.artist = artist
    }
}
