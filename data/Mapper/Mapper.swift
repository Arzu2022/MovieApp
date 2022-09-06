//
//  Mapper.swift
//  data
//
//  Created by AziK's  MAC on 06.09.22.
//

import Foundation
import domain
//
//extension OriginalLanguage {
//    func toDomain() -> MovieEntity.ResultEntity.OriginalLanguageEntity {
//        return MovieEntity.ResultEntity.OriginalLanguageEntity.init(rawValue: self.rawValue) ?? MovieEntity.ResultEntity.OriginalLanguageEntity.en
//    }
//}

extension Result {
    func toDomain() -> MovieEntity.ResultEntity {
        return MovieEntity.ResultEntity(adult: self.adult ?? false, backdropPath: self.backdropPath ?? "", genreIDS: self.genreIDS ?? [Int](), id: self.id ?? 0, originalLanguage: self.originalLanguage ?? "", originalTitle: self.originalTitle ?? "", overview: self.overview ?? "", popularity: self.popularity ?? 0.0, posterPath: self.posterPath ?? "", video: self.video ?? false, releaseDate: self.releaseDate ?? "", title: self.title ?? "", voteAverage: self.voteAverage ?? 0.0, voteCount: self.voteCount ?? 0)
    }
}

extension MovieRemoteDTO {
    func toDomain() -> MovieEntity{
        return MovieEntity.init(results: self.results.map({$0.map {$0.toDomain()}})!)
    }
}
