//
//  TabBar.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import Foundation
import UIKit

public class TabBar: BaseTabController<MovieViewModel> {
    
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
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: Asset.icHome.image,
                                          selectedImage: Asset.icHome.image)
        
        searchNav.tabBarItem = UITabBarItem(title: "Search",
                                            image: Asset.icSearch.image,
                                            selectedImage: Asset.icSearch.image)
        
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: Asset.icProfile.image,
                                             selectedImage: Asset.icProfile.image)
        
        viewControllers = [homeNav, searchNav, profileNav]
    }
}

