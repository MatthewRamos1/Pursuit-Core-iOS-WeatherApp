//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        dateLabel.text = String(forecast.time)
        highTempLabel.text = String(forecast.temperatureHigh)
        lowTempLabel.text = String(forecast.temperatureLow)
        forecastImageView.image = UIImage(named: forecast.icon)
        
    }
    
}
