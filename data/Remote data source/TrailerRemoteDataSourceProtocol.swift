//
//  TrailerRemoteDataSourceProtocol.swift
//  data
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
import Promises

protocol TrailerRemoteDataSourceProtocol{
    func fetch(id:Int) -> Promise<TrailerRemoteDTO>
}
