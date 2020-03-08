//
//  cricketModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation

struct CricketModel{
    
    let uniqueId : Int!
    let date      : String!
    let squad     : Bool!
    let team1    : String!
    let team2    : String!
    let started   : Bool!
    let Score     : String!
    let matchType :String!
    
    init(uniqueId: Int,
         date : String,
         squad :Bool,
         team1 :String,
         team2 :String,
         started : Bool,
         score : String,
         matchType:String) {
        
        self.uniqueId  = uniqueId
        self.date      = date
        self.squad     = squad
        self.team1     = team1
        self.team2     = team2
        self.started   = started
        self.Score     = score
        self.matchType = matchType
    }

}

struct ScoreModel{
    let isStarted : Bool!
    let team1    : String!
    let team2    : String!
    let Score     : String!
    
    init(team1 :String,
         team2 :String,
         isStarted : Bool,
         score : String) {
        self.team1     = team1
        self.team2     = team2
        self.isStarted   = isStarted
        self.Score     = score
    }
    
}

struct SquadsModel{
    let teamName:String!
    let players:[PlayerModel]!
    
    init(teamName:String,
         players:[PlayerModel]) {
        self.teamName = teamName
        self.players = players
    }
}

struct PlayerModel{
    let playerId:Int!
    let PlayerName:String!
    
    init(playerId:Int,
         playerName:String!) {
        self.playerId = playerId
        self.PlayerName = playerName
    }
}
