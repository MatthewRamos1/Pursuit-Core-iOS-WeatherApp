//
//  FavoritesCell.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/7/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    @IBOutlet weak var favoritesImageView: UIImageView!
    
    func configureCell(imageObject: ImageObject) {
        favoritesImageView.image = UIImage(data: imageObject.imageData)
    }
}
