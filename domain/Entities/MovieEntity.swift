

import Foundation
public struct MovieEntity {
    public let results: [ResultEntity]?
    
    public init(results:[ResultEntity]) {
        self.results = results
    }
    public struct ResultEntity {
        public var adult: Bool?
        public var backdropPath: String?
        public var genreIDS: [Int]?
        public var id: Int
        public var originalLanguage: String?
        public var originalTitle, overview: String?
        public var popularity: Double?
        public var posterPath, releaseDate, title: String?
        public var video: Bool?
        public var voteAverage: Double?
        public var voteCount: Int?
        public init(adult: Bool?,
                    backdropPath: String?,
                    genreIDS: [Int]?,
                    id: Int,
                    originalLanguage: String?,
                    originalTitle: String?,
                    overview: String?,
                    popularity: Double?,
                    posterPath: String?,
                    video: Bool?,
                    releaseDate: String?,
                    title: String?,
                    voteAverage: Double?,
                    voteCount: Int
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
}


