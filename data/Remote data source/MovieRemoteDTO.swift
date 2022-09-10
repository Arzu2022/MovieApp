

import Foundation
import domain

public struct MovieRemoteDTO: Decodable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?
}

public struct Result:Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
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
}
 
//public enum OriginalLanguage: String, Decodable {
//    case en = "en"
//    case te = "te"
//    case es = "es"
//    case ja = "ja"
//    case pl = "pl"
//}

