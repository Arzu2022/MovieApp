//
//  GetTrailerUseCase.swift
//  domain
//
//  Created by AziK's  MAC on 13.09.22.
//

import Foundation
import Promises

public class GetTrailerUseCase {
    private let repo: TrailerRepoProtocol
    init(repo: TrailerRepoProtocol){
        self.repo = repo
    }
    public func execute(id:Int) -> Promise<TrailerEntity>{
        return repo.getTrailer(id: id)
    }
}
