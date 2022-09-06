//
//  GetMovieUseCase.swift
//  domain
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Promises

public class GetMovieUseCase {
    private let repo: MovieRepoProtocol
    
    init(repo: MovieRepoProtocol){
        self.repo = repo
    }
    public func execute() -> Promise<MovieEntity>{
        return repo.getMovie()
    }
}
