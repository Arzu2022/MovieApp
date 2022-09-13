//
//  MovieTrailerEntity.swift
//  domain
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation

public struct TrailerEntity {
   public let results: [ResultTrailer]
    public init (results: [ResultTrailer]){
        self.results = results
    }
  public struct ResultTrailer {
       public let key: String
       public let official: Bool
       public init(key:String,official:Bool){
          self.key = key
          self.official = official
      }
//        enum CodingKeys: String, CodingKey {
//            case iso639_1 = "iso_639_1"
//            case iso3166_1 = "iso_3166_1"
//            case name, key
//            case publishedAt = "published_at"
//            case site, size, type, official, id
//        }
    }
}

