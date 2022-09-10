

import Foundation
import Swinject
import domain

public class PresentationAssembly:Assembly {
    public init(){
    }
   public func assemble(container: Container) {
        container.register(FirstViewModel.self) { r in
          return FirstViewModel(getMovieUseCase: r.resolve(GetMovieUseCase.self)!
            )
        }
    }
    
}
