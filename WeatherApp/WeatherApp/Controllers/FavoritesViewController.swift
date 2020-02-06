//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesView  = FavoritesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
    }
    
    override func loadView() {
        view = favoritesView
    }

}
