

import Foundation
import Promises

protocol MovieRemoteDataSourceProtocol{
    func fetch(typeOf:String) -> Promise<MovieRemoteDTO>
    func search()
}
