//
//  TrailerRepo.swift
//  data
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
import domain
import Promises
import RxSwift

class TrailerRepo : TrailerRepoProtocol {
    
    private let remoteDataSourceT:TrailerRemoteDataSourceProtocol
    init(remoteDataSourceT:TrailerRemoteDataSourceProtocol
    ){
        self.remoteDataSourceT = remoteDataSourceT
    }
    func getTrailer(id: Int) -> Promise<TrailerEntity> {
        self.remoteDataSourceT.fetch(id: id).then { dto in
            dto.trailerToDomain()
        }
    }
    
}
