//
//  TrailerRemoteDataSource.swift
//  data
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
import Alamofire
import Promises
class TrailerRemoteDataSource: TrailerRemoteDataSourceProtocol {

    private let networkProvider: Session
    
    init(networkProvider:Session){
        self.networkProvider = networkProvider
    }
    
    func fetch(id: Int) -> Promise<TrailerRemoteDTO> {
        let promise = Promise<TrailerRemoteDTO>.pending()
        let url:String = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=3a0a1bb6b1ceffd7114757c7a605777d"
        networkProvider.request(url)
            .responseDecodable(of: TrailerRemoteDTO.self){ response in
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
    
    
    
    
}
