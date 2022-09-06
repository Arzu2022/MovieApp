//
//  MovieLocalDataSourceProtocol.swift
//  data
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import RxSwift
import Promises

    protocol MovieLocalDataSourceProtocol {
        func observe() -> Observable<MovieLocalDTO>
        func save(movieDTO: MovieLocalDTO) -> Promise<Void>
 }
    
