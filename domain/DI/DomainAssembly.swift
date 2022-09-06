//
//  DomainAssembly.swift
//  domain
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import Swinject


public class DomainAssembly:Assembly {
    public init() {
        
    }
   public  func assemble(container: Container) {
        container.register(GetMovieUseCase.self) { r in
            GetMovieUseCase.init(repo: r.resolve(MovieRepoProtocol.self)!)
        }
//       container.register(SyncMovieUseCase.self) { r in
//           SyncMovieUseCase.init(repo: r.resolve(MovieRepoProtocol.self)!)
//       }
//       container.register(ObserveMovieUseCase.self) { r in
//           ObserveMovieUseCase.init(repo: r.resolve(MovieRepoProtocol.self)!)
//       }
    }
    
    
    
}
