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
       public let key: String?
       public let official: Bool
       public init(key:String,official:Bool){
          self.key = key
          self.official = official
      }
    }
}

