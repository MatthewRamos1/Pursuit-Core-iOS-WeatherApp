//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesView  = FavoritesView()
    
    private var favorites = [ImageObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        favoritesView.collectionView.delegate = self
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    

}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesView.collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath)
        return cell

    }


}

extension FavoritesViewController: UICollectionViewDelegate {
    
}
