//
//  MovieLocalDataSource.swift
//  data
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import RxRelay
import RxSwift
import Promises

class MovieLocalDataSource: MovieLocalDataSourceProtocol {
    private let movieRelay = BehaviorRelay<MovieLocalDTO?>.init(value: nil)
    
    func observe() -> Observable<MovieLocalDTO> {
        return movieRelay
            .filter({ m in
                m != nil
            })
            .map({ m in
                m!
            })
            .asObservable()
    }
    
    func save(movieDTO: MovieLocalDTO) -> Promise<Void> {
        let promise = Promise<Void>.pending()
        self.movieRelay.accept(movieDTO)
        promise.fulfill(Void())
        return promise
    }
}
