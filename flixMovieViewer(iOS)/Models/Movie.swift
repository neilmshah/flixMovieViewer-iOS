//
//  Movie.swift
//  flixMovieViewer(iOS)
//
//  Created by Neil Shah on 10/5/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview: String
    let baseURLString: String = "https://image.tmdb.org/t/p/w500"
    var posterPathString: String?
    var backDropPathString: String?
    var posterURL: URL?
    var backDropURL : URL?
    var releaseDate: String?
    
    init(dictionary: [String:Any]) {
        print("Movie init")
        title = dictionary["title"] as? String ?? "No Title"
        overview = dictionary["overview"] as? String ?? "No Overview"
        posterPathString = dictionary["poster_path"] as? String ?? "No posterURL"
        posterURL = URL(string: baseURLString + posterPathString!)
        backDropPathString = dictionary["backdrop_path"] as? String ?? "No backdropURL"
        backDropURL = URL(string: baseURLString + backDropPathString!)
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
    
    
}
