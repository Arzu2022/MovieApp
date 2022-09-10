import Foundation
import Swinject
import domain
import UIKit

public protocol RouterProtocol {
    func firstViewController() -> HomeVC
    func tabbarController() -> TabBar
}

public class Router: RouterProtocol {
    private let resolver: Resolver
    
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func firstViewController() -> HomeVC {
        let vc = HomeVC()
        vc.vm = resolver.resolve(FirstViewModel.self)!
        vc.router = self
        return vc
    }
    
    public func tabbarController() -> TabBar {
        let tabbar = TabBar()
        return tabbar
    }
    
}
