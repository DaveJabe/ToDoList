//
//  TabBarViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        
        let fvc = FocusViewController()
        fvc.title = "Focus"
        
        let tdvc = ToDoViewController()
        tdvc.title = "Today's Tasks"
        
        let pvc = ProfileViewController()
        pvc.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: fvc)
        let nav2 = UINavigationController(rootViewController: tdvc)
        let nav3 = UINavigationController(rootViewController: pvc)
        
        nav1.tabBarItem = UITabBarItem(title: nil,
                                       image: UIImage(systemName: SFSymbol.focusTab),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil,
                                       image: UIImage(systemName: SFSymbol.homeTab),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: nil,
                                       image: UIImage(systemName: SFSymbol.profileTab),
                                       tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        selectedIndex = 1
    }
}
