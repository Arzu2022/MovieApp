//
//  HomeViewModel.swift
//  presentation
//
//  Created by AziK's  MAC on 10.09.22.
//

import Foundation
import Promises
import domain
import RxSwift

public class HomeViewModel {
    
    private let getMovieUseCase: GetMovieUseCase
    public init(getMovieUseCase: GetMovieUseCase) {
        self.getMovieUseCase = getMovieUseCase
    }
    
    func getMovie() -> Promise<MovieEntity> {
        let useCase = self.getMovieUseCase
        return useCase.execute()
    }
    
    
}
