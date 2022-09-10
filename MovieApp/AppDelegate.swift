import UIKit
import Swinject
import domain
import data
import presentation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let assembler = Assembler([DomainAssembly(),DataAssembly(),PresentationAssembly()])
        let router :RouterProtocol = Router.init(resolver: assembler.resolver)
        
        let tabbarController = router.tabbarController()
//        let navigation = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }

}

