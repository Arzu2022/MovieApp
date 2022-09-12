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
   // private let localDataSource:MovieLocalDataSourceProtocol
// let behaviorSubject = BehaviorSubject<MovieEntity?>.init(value: nil)
    
    init(remoteDataSource:MovieRemoteDataSourceProtocol
        // localDataSource:MovieLocalDataSourceProtocol
    ){
        self.remoteDataSource = remoteDataSource
       // self.localDataSource = localDataSource
    }
    func getMovie(typeOfMovie:String) -> Promise<MovieEntity> {
        self.remoteDataSource.fetch(typeOf: typeOfMovie).then { dto in
            dto.toDomain()
        }
    }
    
//    func observeMovie() -> Observable<MovieEntity> {
//        return self.localDataSource.observe().map { dto in
//            dto.toDomain()
//        }
//    }
//    func syncMovie() -> Promise<Void> {
//        let promise = Promise<Void>.pending()
//
//        self.remoteDataSource.fetch().then { dto -> Promise<Void> in
////            let local = dto.toLocal()
//            return self.localDataSource.save(movieDTO: local)
//        }
//        .then { void in
//            promise.fulfill(void)
//        }
//        .catch { err in
//            promise.reject(err)
//        }
//
//        return promise
//    }
    
    
    
}
