//
//  CricketViewModel.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import RxSwift

class CricketViewModel {
    
    var model:[CricketModel] = [CricketModel]()
    var scoreModel:ScoreModel?
    var squadsModel:[SquadsModel] = [SquadsModel]()
    
    let matchServices = ServiceManager()
    let cellSelectedEvent = PublishSubject<Void>()
    let isCellSelectedEvent = Variable<Bool>(false)

    func getNewMatches(completed:@escaping (Bool) -> ()){
        matchServices.CricketServicesGET(STRURL: cricketNewMatchesURL){
            
            responseMatches,error in
            
            guard responseMatches != nil && error == nil else {
                return
            }
            
            let matchesTempArray = responseMatches!["matches"]
            
            for matches in matchesTempArray as! [AnyObject] {
                
                let unique_id = matches["unique_id"] as! Int
                let date      = matches["date"] as! String
                let squad     = matches["squad"] as! Bool
                let team_1    = matches["team-1"] as! String
                let team_2    = matches["team-2"] as! String
                let started   = matches["matchStarted"] as! Bool
                let matchType = matches["type"] as! String
                let score = ""
                
                let matchesModel = CricketModel(uniqueId: unique_id , date: date, squad: squad, team1: team_1, team2: team_2, started: started,score: score,matchType:matchType)
                
                self.model.append(matchesModel)
                
            }
            
            completed(true)
            
        }
    }
    
    func numberOfMatches()->Int{
        return self.model.count
    }

    func getScore(uniqueId:String,completed:@escaping (Bool) -> ()){
        
        let scoreUrl = cricketScoreUrl + uniqueId
        
        matchServices.CricketServicesGET(STRURL: scoreUrl){
            
            responseScores,error in
            
            guard responseScores != nil && error == nil else {
                return
            }
            
     
            let isStarted  = responseScores!["matchStarted"] as! Bool
            let team1     = responseScores!["team-1"] as! String
            let team2    = responseScores!["team-2"] as! String
            let score    = responseScores!["score"] as? String ?? "NIL"
            
            
            self.scoreModel = ScoreModel(team1: team1,
                                         team2: team2,
                                         isStarted: isStarted,
                                         score: score)
            
           
            
            completed(true)
            
        }
    }
    
    func getSquads(matchId:String,completed:@escaping (Bool) -> ()){
        let squadsUrl = cricketSquadsUrl + matchId
        
        matchServices.CricketServicesGET(STRURL: squadsUrl){
            
            responseSquads,error in
            
            guard responseSquads != nil && error == nil else {
                return
            }
            
            let squads = responseSquads!["squad"]
            
            for squad in squads as! [AnyObject]{
                
                var playerModelArray:[PlayerModel] = [PlayerModel]()
                let name = squad["name"] as? String ?? "No One"
                let players = squad["players"]
                
                for player in players! as! [AnyObject]{
                    
                    let id = player["pid"] as! Int
                    let name = player["name"] as? String ?? "No One"
                    
                    let playerModel = PlayerModel(playerId: id,
                                                  playerName: name)
                    
                    playerModelArray.append(playerModel)
                }
                
                
                let squadModel = SquadsModel(teamName: name,
                                             players: playerModelArray)
                
                self.squadsModel.append(squadModel)
            }
           
            
            completed(true)
            
        }
    }
    
    func getPlayerImageUrl(pId:String,completed:@escaping (String,String) -> ()){
        
        let playerImageurl = cricketPlayerImageUrl + pId
        
        matchServices.CricketServicesGET(STRURL: playerImageurl){
            
            responsePlayer,error in
            
            guard responsePlayer != nil && error == nil else {
                return
            }
            
            let imageUrl = responsePlayer!["imageURL"] as? String ?? "Https://"
            let playingRole = responsePlayer!["playingRole"] as?String ?? "NA"
            
            completed(imageUrl,playingRole)
            
        }
    }
    
    func numberOfTeams()->Int{
        return squadsModel.count
    }
   
    
}
