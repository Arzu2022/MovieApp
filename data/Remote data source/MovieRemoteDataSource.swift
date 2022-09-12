
import Foundation
import Alamofire
import Promises
class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    private let networkProvider: Session
    init(networkProvider:Session){
        
        self.networkProvider = networkProvider
    }
    func fetch(typeOf:String) -> Promise<MovieRemoteDTO> {
        let promise = Promise<MovieRemoteDTO>.pending()
        var url:String = "https://api.themoviedb.org/3/movie/popular?api_key=3a0a1bb6b1ceffd7114757c7a605777d"
        if typeOf == "top_rated" {
            url = "https://api.themoviedb.org/3/movie/top_rated?api_key=3a0a1bb6b1ceffd7114757c7a605777d"
        }
        else if typeOf == "upcoming" {
        url = "https://api.themoviedb.org/3/movie/upcoming?api_key=3a0a1bb6b1ceffd7114757c7a605777d"
        }
        else if typeOf == "kids" {
            url = "https://api.themoviedb.org/3/discover/movie?api_key=3a0a1bb6b1ceffd7114757c7a605777d&with_genres=16"
        }
        networkProvider.request(url)
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
            }
        return promise
        
    }
    
    func search() {
        
    }
}

class ParsingError: Error {
    
}
