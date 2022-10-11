//
//  AppDelegate.swift
//  EffectiveMobile
//
//  Created by  User on 22.08.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let explorerPresenter = ExplorerPresenter(url: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        let explorerView = ExplorerViewController(presenter: explorerPresenter)
        explorerPresenter.view = explorerView
        let explorerNavController = UINavigationController(rootViewController: explorerView)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [explorerNavController]
        
        
        let exploreItem = UITabBarItem()
        exploreItem.title = "Explorer"
        explorerNavController.tabBarItem = exploreItem
        
        
        tabBar.tabBar.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        tabBar.tabBar.layer.cornerRadius = 30
        tabBar.tabBar.clipsToBounds = true
    
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
}

