//
//  TrailerRemoteDTO.swift
//  data
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
public struct TrailerRemoteDTO: Decodable {
    let id: Int?
    let results: [ResultTrailer]?
}

// MARK: - Result
public struct ResultTrailer: Decodable {
    let iso639_1, iso3166_1, name, key: String?
    let publishedAt, site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key
        case publishedAt = "published_at"
        case site, size, type, official, id
    }
}
