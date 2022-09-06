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
//    private let syncMovieUseCase: SyncMovieUseCase
//    private let observeMovieUseCase: ObserveMovieUseCase
    
    public init(
        getMovieUseCase: GetMovieUseCase
//        syncMovieUseCase: SyncMovieUseCase,
//        observeMovieUseCase: ObserveMovieUseCase
    ){
        self.getMovieUseCase = getMovieUseCase
//        self.syncMovieUseCase = syncMovieUseCase
//        self.observeMovieUseCase = observeMovieUseCase
    }
    func getMovie() -> Promise<MovieEntity> {
        let useCase = self.getMovieUseCase
        return useCase.execute()
    }
//    func syncMovie() {
//        self.syncMovieUseCase.execute()
//    }
//    func observeMovie() -> Observable<MovieEntity> {
//        return self.observeMovieUseCase.execute()
//    }
}
