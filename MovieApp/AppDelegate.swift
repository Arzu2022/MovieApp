import UIKit
import Swinject
import domain
import data
import presentation
import FirebaseAuth
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // AppLoader.self.instance.showLoaderView()
        let assembler = Assembler([DomainAssembly(),DataAssembly(),PresentationAssembly()])
        let router :RouterProtocol = Router.init(resolver: assembler.resolver)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if Auth.auth().currentUser == nil {
           let login = router.loginVC()
           let navigationController = UINavigationController(rootViewController: login)
           navigationController.isNavigationBarHidden = true
            window?.rootViewController = navigationController
        }
        else {
            let tabbar = router.tabbarController()
            let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.isNavigationBarHidden = true
            window?.rootViewController = navigationController
        }
        //AppLoader.self.instance.hideLoaderView()
        return true
    }

}

