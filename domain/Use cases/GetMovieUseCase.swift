

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
