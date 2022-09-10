

import Foundation
import Swinject
import domain
import Alamofire

public class DataAssembly:Assembly {
   public init(){
        
    }
   let session = Session(eventMonitors: [ AlamofireLogger() ])
   public func assemble(container: Container) {
        container.register(MovieRepoProtocol.self) { r in
            MovieRepo(remoteDataSource: r.resolve(MovieRemoteDataSourceProtocol.self)!
                      //localDataSource: r.resolve(MovieLocalDataSourceProtocol.self)!
            )
        }
       container.register(MovieRemoteDataSourceProtocol.self) { r in
           MovieRemoteDataSource(networkProvider: r.resolve(Session.self)!)
       }.inObjectScope(.container)
       
       container.register(Session.self) { _ in
           return self.session
       }
       container.register(MovieLocalDataSourceProtocol.self) { _ in
           MovieLocalDataSource()
       }.inObjectScope(.container)
    }
}
final class AlamofireLogger: EventMonitor {
    
    func requestDidResume(_ request: Request) {

        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let headers = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Headers: \(allHeaders)
        """
        NSLog(headers)


        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Body Data: \(body)
        """
        NSLog(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {

        NSLog("⚡️⚡️⚡️⚡️ Response Received: \(response.debugDescription)")
        NSLog("⚡️⚡️⚡️⚡️ Response All Headers: \(String(describing: response.response?.allHeaderFields))")
    }
}
