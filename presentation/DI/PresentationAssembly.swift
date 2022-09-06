//
//  PresentationAssembly.swift
//  presentation
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Swinject
import domain

public class PresentationAssembly:Assembly {
    public init() {
        
    }
   public func assemble(container: Container) {
        container.register(FirstViewModel.self) { r in
          return FirstViewModel(getMovieUseCase: r.resolve(GetMovieUseCase.self)!
//                           syncMovieUseCase: r.resolve(SyncMovieUseCase.self)!,
//                           observeMovieUseCase: r.resolve(ObserveMovieUseCase.self)!
            )
        }
    }
    
}
