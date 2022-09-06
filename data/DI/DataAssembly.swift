

import Foundation
import Swinject
import domain
import Alamofire
public class DataAssembly:Assembly {
   public init(){
        
    }
   public func assemble(container: Container) {
        container.register(MovieRepoProtocol.self) { r in
            MovieRepo(remoteDataSource: r.resolve(MovieRemoteDataSourceProtocol.self)!
                      //localDataSource: r.resolve(MovieLocalDataSourceProtocol.self)!
            )
        }
       container.register(MovieRemoteDataSourceProtocol.self) { r in
           MovieRemoteDataSource(networkProvider: r.resolve(Session.self)!)
       }
       container.register(Session.self) { _ in
           return AF
       }
       container.register(MovieLocalDataSourceProtocol.self) { _ in
           MovieLocalDataSource()
       }.inObjectScope(.container)
    }
}
