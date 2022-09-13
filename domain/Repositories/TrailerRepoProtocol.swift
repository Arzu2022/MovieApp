//
//  TrailerRepoProtocol.swift
//  domain
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
import Promises
import RxSwift

public protocol TrailerRepoProtocol {
    func getTrailer(id:Int) -> Promise<TrailerEntity>
}
