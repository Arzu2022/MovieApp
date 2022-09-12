//
//  BaseViewController.swift
//  presentation
//
//  Created by AziK's  MAC on 28.08.22.
//

import Foundation
import UIKit

public class BaseViewController<VM>: UIViewController {
    var vm :VM? = nil
    var router:RouterProtocol? = nil
    
}

public class BaseTabController<VM>: UITabBarController {
    var vm: VM
    var router:RouterProtocol
    
    init(
        vm: VM,
        router: RouterProtocol
    ) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
