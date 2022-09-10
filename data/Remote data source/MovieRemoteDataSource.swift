
import Foundation
import Alamofire
import Promises
class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    private let networkProvider: Session
    init(networkProvider:Session){
        
        self.networkProvider = networkProvider
    }
    func fetch() -> Promise<MovieRemoteDTO> {
        let promise = Promise<MovieRemoteDTO>.pending()
        
        networkProvider.request("https://api.themoviedb.org/3/discover/movie?api_key=3a0a1bb6b1ceffd7114757c7a605777d")
            .responseDecodable(of: MovieRemoteDTO.self){ response in
                if let status = response.response?.statusCode {
                    print(status)
                }
                if let err = response.error{
                    promise.reject(err)
                    return
                }
                if let data = response.value{
                    promise.fulfill(data)
                } else{
                    promise.reject(ParsingError())
                }
        
        
//        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=3a0a1bb6b1ceffd7114757c7a605777d", method: .get, headers: .default).responseJSON { response in
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 201:
//                    print(response.value)
//                default:
//                    print("is not 201")
//                }
//        }
            }
        return promise
        
    }
    
    func search() {
        
    }
}

class ParsingError: Error {
    
}
