

import Foundation
import Swinject
import domain

public class PresentationAssembly:Assembly {
    public init(){
    }
   public func assemble(container: Container) {
       container.register(MovieViewModel.self) { r in
          return MovieViewModel(getMovieUseCase: r.resolve(GetMovieUseCase.self)!)
        }
       container.register(TrailerViewModel.self) { r in
           return TrailerViewModel(getTrailerUseCase: r.resolve(GetTrailerUseCase.self)!)
       }
    }
    
}
