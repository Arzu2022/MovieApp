
import Foundation
import Alamofire
import Promises
class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    private let networkProvider:Session
    
    init(networkProvider:Session){
        self.networkProvider = networkProvider
    }
    
    func fetch() -> Promise<MovieRemoteDTO> {
        let promise = Promise<MovieRemoteDTO>.pending()
        
        networkProvider.request("https://api.themoviedb.org/3/discover/movie?api_key=3a0a1bb6b1ceffd7114757c7a605777d")
            .responseDecodable(of: MovieRemoteDTO.self){ response in
                if let err = response.error{
                    promise.reject(err)
                    return
                }
                if let data = response.value{
                    promise.fulfill(data)
                } else{
                    promise.reject(ParsingError())
                }
            }
        return promise
    }
    
    func search() {
        
    }
}

class ParsingError: Error {
    
}
