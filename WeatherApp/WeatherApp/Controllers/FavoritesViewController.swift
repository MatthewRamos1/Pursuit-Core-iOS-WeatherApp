//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private let favoritesView  = FavoritesView()
    private let dataPeristence = DataPersistence<ImageObject>(filename: "images.plist")
    
    private var favorites = [ImageObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        favoritesView.collectionView.delegate = self
        favoritesView.collectionView.dataSource = self
        favoritesView.collectionView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellWithReuseIdentifier: "favoritesCell")
        loadImageObjects()
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    func loadImageObjects() {
            do {
                favorites = try dataPersistence.loadItems()
            } catch {
                fatalError("Couldn't load objects")
            }
        }
    }
    
    



extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoritesView.collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("Couldn't downcast to FavoritesCell")
        }
        let favorite = favorites[indexPath.row]
        cell.configureCell(imageObject: favorite)
        return cell

    }


}

extension FavoritesViewController: UICollectionViewDelegate {
    
}
