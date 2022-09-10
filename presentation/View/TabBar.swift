//
//  TabBar.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import Foundation
import UIKit

public class TabBar: BaseTabController<FirstViewModel> {
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        let homeVC = router.homeVCfunc()
        let searchVC = router.searchVc()
        let profileVC = router.profileVC()
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        tabBar.tintColor = .red
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .black
        
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(named: "ic_home"),
                                          selectedImage: UIImage(named: "ic_home"))
        
        searchNav.tabBarItem = UITabBarItem(title: "Search",
                                            image: UIImage(named: "ic_search"),
                                            selectedImage: UIImage(named: "ic_search"))
        
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(named: "ic_profile"),
                                             selectedImage: UIImage(named: "ic_profile"))
        
        viewControllers = [homeNav, searchNav, profileNav]
    }
}

