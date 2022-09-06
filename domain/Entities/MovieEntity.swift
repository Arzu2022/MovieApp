

import Foundation
public struct MovieEntity {
    public let results: [ResultEntity]?
    public init(
               results:[ResultEntity]){
               self.results = results
    }
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct ResultEntity {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public let originalLanguage: OriginalLanguageEntity?
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public init(adult: Bool?,
                backdropPath: String?,
                genreIDS: [Int]?,
                id: Int?,
                originalLanguage: OriginalLanguageEntity?,
                originalTitle: String?,
                overview: String?,
                popularity: Double?,
                posterPath: String?,
                video: Bool?,
                releaseDate: String?,
                title: String?,
                voteAverage: Double?,
                voteCount: Int?
    ){
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.video = video
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

public enum OriginalLanguageEntity: String {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case pl = "pl"
}
