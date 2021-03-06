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

}
