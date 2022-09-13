import Foundation
import Swinject
import domain
import UIKit

public protocol RouterProtocol {
    func homeVCfunc() -> HomeVC
    func searchVc() -> SearchVC
    func profileVC() -> ProfileVC
    func didSelectVC(allData:MovieEntity.ResultEntity) -> DidSelectVC
    func tabbarController() -> TabBar
}

public class Router: RouterProtocol {
    public func didSelectVC(allData:MovieEntity.ResultEntity) -> DidSelectVC {
        let vc = DidSelectVC(allData: allData)
        vc.vm = resolver.resolve(TrailerViewModel.self)!
        vc.router = self
        return vc
    }
    
    public func searchVc() -> SearchVC {
        let vc = SearchVC()
        vc.vm = resolver.resolve(MovieViewModel.self)!
        vc.router = self
        return vc
    }
    
    public func profileVC() -> ProfileVC {
        let vc = ProfileVC()
        vc.vm = resolver.resolve(MovieViewModel.self)!
        vc.router = self
        return vc
    }
    
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func homeVCfunc() -> HomeVC {
        let vc = HomeVC()
        vc.vm = resolver.resolve(MovieViewModel.self)!
        vc.router = self
        return vc
    }
    
    public func tabbarController() -> TabBar {
        let tabbar = TabBar(
            vm: resolver.resolve(MovieViewModel.self)!,
            router: self
        )
        return tabbar
    }
    
}
