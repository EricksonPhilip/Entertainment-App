//
//  API.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation

//MARK: Cricket
public let cricketScores_URL : String = "http://cricapi.com/api/cricketScore"
public let cricketScoreUrl = "https://cricapi.com/api/cricketScore?apikey=baFuEphprRdmQU6PvGPn8oKN34j2&&unique_id="
public let cricketSquadsUrl = "http://cricapi.com/api/fantasySquad?apikey=baFuEphprRdmQU6PvGPn8oKN34j2&&unique_id="
public let cricketNewMatchesURL = "https://cricapi.com/api/matches?apikey=baFuEphprRdmQU6PvGPn8oKN34j2"
public let cricketPlayerImageUrl = "http://cricapi.com/api/playerStats?apikey=baFuEphprRdmQU6PvGPn8oKN34j2&pid="

//MARK: News
public let newsSource_URL = "https://newsapi.org/v1/sources?language=en"
public let newsArticle_URL_1 = "https://newsapi.org/v1/articles?source="
public let newsArticle_URL_2 = "&sortBy=top&apiKey=b3f58016371a4e0baddb044e5cd2f6ea"
public let topHeadLinesURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=b3f58016371a4e0baddb044e5cd2f6ea"

//MARK: Movies & TV
public let moviesToken_URL:String = "https://api.themoviedb.org/3/authentication/token/new?api_key=14264aed83f07b9301a1ac16e7a23325"

public let moviesSession_URL:String = "https://api.themoviedb.org/3/authentication/session/new?api_key=14264aed83f07b9301a1ac16e7a23325&request_token="

public let moviesPopularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=14264aed83f07b9301a1ac16e7a23325&language=en-US&page="
public let moviesLatestUrl = "https://api.themoviedb.org/3/movie/latest?api_key=14264aed83f07b9301a1ac16e7a23325&language=en-US"
public let moviesTopRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=14264aed83f07b9301a1ac16e7a23325&language=en-US&page="
public let moviesNowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=14264aed83f07b9301a1ac16e7a23325&language=en-US&page="
public let moviesUpcomingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=14264aed83f07b9301a1ac16e7a23325&language=en-US&page="

public let moviePosterBaseUrl = "http://image.tmdb.org/t/p/w500/"
public let movieBackDropBaseUrl = "http://image.tmdb.org/t/p/w780/"

public let movievLargeBackDropUrl = "http://image.tmdb.org/t/p/w1280/"

public let popularTVUrl = "https://api.themoviedb.org/3/tv/popular?page=1&language=en-US&api_key=14264aed83f07b9301a1ac16e7a23325"

//MARK: Music
public let musicTopArtistUrl = "http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=3609d3a8d5793c18b5058b8e546eb45d&format=json"
public let musicTopTracksUrl = "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=3609d3a8d5793c18b5058b8e546eb45d&format=json"

//MARK: Weather
public let currentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?id=4671576&appid=\(weather_API_Key)"
public let weatherBaseImageUrl = "http://openweathermap.org/img/w/"

public let covidAPI = "https://api.covid19api.com/summary"

public let movie_API_Key = "14264aed83f07b9301a1ac16e7a23325"
public let music_API_key = "3609d3a8d5793c18b5058b8e546eb45d"
public let weather_API_Key = "d53b2b21c73db25226c6202e675f40ff"
