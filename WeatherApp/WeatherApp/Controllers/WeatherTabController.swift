//
//  WeatherTabController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabController: UITabBarController {
    
//    private lazy var navController: UINavigationController = {
//        let navController = UINavigationController()
//
//        return navController
//    }()
    private lazy var viewController: UIViewController = {
        let vc = ViewController()
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: viewController)]
    }
}
