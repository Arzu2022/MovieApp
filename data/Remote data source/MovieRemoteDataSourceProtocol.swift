//
//  MovieRemoteDataSource.swift
//  data
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Promises

protocol MovieRemoteDataSourceProtocol{
    func fetch() -> Promise<MovieRemoteDTO>
}
