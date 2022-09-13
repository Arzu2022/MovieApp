//
//  MovieRepo.swift
//  data
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import domain
import Promises
import RxSwift

class MovieRepo : MovieRepoProtocol {
    private let remoteDataSource:MovieRemoteDataSourceProtocol
    init(remoteDataSource:MovieRemoteDataSourceProtocol
    ){
        self.remoteDataSource = remoteDataSource
    }
    func getMovie(typeOfMovie:String) -> Promise<MovieEntity> {
        self.remoteDataSource.fetch(typeOf: typeOfMovie).then { dto in
            dto.toDomain()
        }
    }
}
