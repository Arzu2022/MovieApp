

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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = router.firstViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}

