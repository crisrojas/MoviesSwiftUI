//
//  CreditsResponse.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

// MARK: - CreditsResponse
struct CreditsResponse: Decodable {
    internal init(creditType: String?, department: String?, job: String?, media: Movie?, mediaType: String?, id: String?, person: Person?) {
        self.creditType = creditType
        self.department = department
        self.job = job
        self.media = media
        self.mediaType = mediaType
        self.id = id
        self.person = person
    }
    
    let creditType, department, job: String?
    let media: Movie?
    let mediaType, id: String?
    let person: Person?
}

// MARK: - Media === Movie
//struct Media: Decodable, Identifiable {
//    let id: Int?
//    let video: Bool?
//    let voteCount: Int?
//    let voteAverage: Double?
//    let title, releaseDate, originalLanguage, originalTitle: String?
//    let genreIDS: [Int]?
//    let backdropPath: String?
//    let adult: Bool?
//    let overview, posterPath: String?
//    let popularity: Double?
//    let character, mediaType: String?
//    
//    var backdropURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
//    }
//    
//    var posterURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
//    }
//}

// MARK: - Person
struct Person: Decodable {
    let adult: Bool?
    let gender: Int?
    let name: String?
    let id: Int?
    let knownFor: [Movie]?
    let knownForDepartment, profilePath: String?
    let popularity: Double?
    
    var profileURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}


extension CreditsResponse {
    static var mock: CreditsResponse = CreditsResponse(creditType: "", department: "", job: "", media: nil, mediaType: "", id: "", person: nil)
    static var localCredits: CreditsResponse {
        let response: CreditsResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "credit_info")
        return response ?? mock
    }
}
