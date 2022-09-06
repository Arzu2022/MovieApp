

import Foundation
import Promises

protocol MovieRemoteDataSourceProtocol{
    func fetch() -> Promise<MovieRemoteDTO>
}
