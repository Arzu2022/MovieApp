//
//  MovieRepoProtocol.swift
//  domain
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Promises
import RxSwift

public protocol MovieRepoProtocol {
    func getMovie(typeOfMovie:String) -> Promise<MovieEntity>
}
