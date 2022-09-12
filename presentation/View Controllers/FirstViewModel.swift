//
//  FirstViewModel.swift
//  presentation
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Promises
import domain
import RxSwift
public class FirstViewModel {
    
    private let getMovieUseCase: GetMovieUseCase
    public init(getMovieUseCase: GetMovieUseCase) {
        self.getMovieUseCase = getMovieUseCase
    }
    
    func getMovie(typeOfMovie:String) -> Promise<MovieEntity> {
        let useCase = self.getMovieUseCase
        return useCase.execute(typeOfMovie: typeOfMovie)
    }
}
