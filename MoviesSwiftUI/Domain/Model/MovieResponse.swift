//
//  MovieResponse.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

/// @todo:
/// To many computed variables. Refacto
/// Maybe use manual decoding
/// Model is too fat
/// Make model dumber (create methods for rating stars)
///  Use struct instead of class
// MARK: Movie Model
struct Movie: Decodable, Identifiable {
    
    init(
        id: Int,
        title: String?,
        backdropPath: String?,
        posterPath: String?,
        overview: String,
        voteAverage: Double,
        voteCount: Int,
        runtime: Int?,
        releaseDate: String?,
        genres: [Genre]?,
        credits: MovieCredits?,
        videos: MovieVideoResponse?,
        originalLanguage: String
    ) {
        self.id = id
        self.title = title
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.overview = overview
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.genres = genres
        self.credits = credits
        self.videos = videos
        self.originalLanguage = originalLanguage
    }

    let id: Int
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    let originalLanguage: String?
    
    let genres: [Genre]?
    
    // @todo
    // Created on init
    var genresList: String? {
        guard let genres = genres else { return nil }
        return genres.map { $0.name }.joined(separator: ", ")
    }
    
    let credits: MovieCredits?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "N/A"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            
            return acc + "★"
        }
        
        return ratingText
    }
    
    var ratingStarsOutOfFive: String {
        let rating = Int(voteAverage/2)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            
            return acc + "★"
        }
        if rating < 5 {
            let numOfMissingStars = 5 - rating
            var missingStars = ""
            for _ in 1...numOfMissingStars {
                missingStars.append("✩")
            }
//            let missingStars = (0..<numOfMissingStars).reduce("") { (acc, _) -> String in
//                return acc + "⭐︎"
//            }
            return ratingText + missingStars
        }
        return ratingText
        
    }

    var voteAverageRounded: String {
        return "\(voteAverage.reduceScale(to: 1))"
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "N/A"
        }
        return "\(ratingText.count)/10"
    }
    
    var languageText: String {
        guard let originalLanguage = self.originalLanguage else { return "N/A" }
        
        return originalLanguage
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "N/A"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "N/A"
        }
        
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "N/A"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    /// @todo: Create an enum
    /// Use this information to create two Carousels
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producers" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    // @todo: delete
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
    var youtubeURL: URL? {
        videos?.results
            .filter { $0.youtubeURL != nil }
            .first?
            .youtubeURL
    }
}


/// @todo: why this needs to be hasable? don't remember... delete?
extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// @todo: delete
// MARK: Stubbs
extension Movie {
    
    static var localMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var localMovie: Movie {
        localMovies[0]
    }
    
     static let mock = Movie(id: -1, title: "", backdropPath: "", posterPath: "", overview: "", voteAverage: 0.0, voteCount: 0, runtime: 0, releaseDate: "", genres: nil, credits: nil, videos: nil, originalLanguage: "")
}
