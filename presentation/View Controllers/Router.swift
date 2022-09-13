import Foundation
import Swinject
import domain
import UIKit

public protocol RouterProtocol {
    func homeVCfunc() -> HomeVC
    func searchVc() -> SearchVC
    func profileVC() -> ProfileVC
    func detailsVC(allData:MovieEntity.ResultEntity) -> DidSelectVC
    func tabbarController() -> TabBar
}

public class Router: RouterProtocol {
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func detailsVC(allData:MovieEntity.ResultEntity) -> DidSelectVC {
        let vc = DidSelectVC(
            allData: allData,
            vm: resolver.resolve(TrailerViewModel.self)!,
            router: self
        )
        return vc
    }
    
    public func searchVc() -> SearchVC {
        let vc = SearchVC(vm: resolver.resolve(MovieViewModel.self)!, router: self)
        return vc
    }
    
    public func profileVC() -> ProfileVC {
        let vc = ProfileVC(
            vm: resolver.resolve(MovieViewModel.self)!,
            router: self
        )
        return vc
    }
    
    public func homeVCfunc() -> HomeVC {
        let vc = HomeVC(
            vm: resolver.resolve(MovieViewModel.self)!,
            router: self
        )
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
