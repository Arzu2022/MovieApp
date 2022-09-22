

import Foundation
import Swinject
import domain
import Firebase
public class PresentationAssembly:Assembly {
    public init(){
        FirebaseApp.configure()
    }
   public func assemble(container: Container) {
       container.register(MovieViewModel.self) { r in
          return MovieViewModel(getMovieUseCase: r.resolve(GetMovieUseCase.self)!)
        }
       container.register(TrailerViewModel.self) { r in
           return TrailerViewModel(getTrailerUseCase: r.resolve(GetTrailerUseCase.self)!)
       }
       
       container.register(TabBar.self) { r in
           TabBar(vm: r.resolve(MovieViewModel.self)!,
                  router: r.resolve(RouterProtocol.self)!
           )
       }.inObjectScope(.container)
       
       container.register(RouterProtocol.self) { r in
           Router(resolver: r)
       }
   }
    
}
