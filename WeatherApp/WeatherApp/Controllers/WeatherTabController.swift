//
//  WeatherTabController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabController: UITabBarController {
    
    private lazy var navController: UINavigationController = {
        let navController = UINavigationController(rootViewController: ViewController())
        navController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return navController
    }()
    
    private lazy var favoritesViewController: UIViewController = {
        let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [navController, favoritesViewController]
    }
}
