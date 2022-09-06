//
//  MovieRemoteDTO.swift
//  data
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import domain

 struct MovieRemoteDTO : Decodable {
     let page: Int
     let results: [Result]
     let totalPages, totalResults: Int
     
     func toDomain() -> MovieEntity{
         MovieEntity(results: self.results.map { $0.toDomain } )
     }
//     func toLocal() -> MovieLocalDTO {
//         return MovieLocalDTO.init(page: self.page, totalResults: self.totalResults)
//     }
     
}
struct Result:Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var toDomain: ResultEntity {
        ResultEntity(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIDS: self.genreIDS,
            id: self.id,
            originalLanguage: self.originalLanguage?.toDomain,
            originalTitle: self.originalTitle,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            video: self.video,
            releaseDate: self.releaseDate,
            title: self.title,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount
        )
    }
}
 
public enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case pl = "pl"
    
    var toDomain: OriginalLanguageEntity {
        switch self {
        case .en:
            return .en
        case .es:
            return .es
        case .ja:
            return .ja
        case .pl:
            return .pl
        }
    }
}

