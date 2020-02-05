//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let mainWeatherView = MainWeatherView()
    private var forecasts = [Forecast]() {
        didSet {
            DispatchQueue.main.async {
                self.mainWeatherView.collectionView.reloadData()
            }
        }
    }
    private var test = "11423"
    override func loadView() {
        view = mainWeatherView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        view.backgroundColor = .white
        mainWeatherView.collectionView.dataSource = self
        getForecasts(zipcode: test)
        
        mainWeatherView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")
    }
    
    
    
    func getForecasts(zipcode: String) {
        var coordinates: String = ""
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { [weak self] (result) in
            switch result {
            case .failure(let fetchingError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Couldn't get location from zip: \(fetchingError)")
                }
                return
            case .success(let coordinatesRaw):
                let lat = String(coordinatesRaw.0)
                let long = String(coordinatesRaw.1)
                coordinates = "\(lat),\(long)"
            }
        }
        
        ForecastAPIClient.fetchForecasts(coordinates: coordinates) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Couldn't get Forecast data: \(appError)")
                }
            case .success(let forecastData):
                DispatchQueue.main.async {
                    self?.mainWeatherView.cityNameLabel.text = forecastData.timezone
                }
                let forecasts = forecastData.daily.data
                self?.forecasts = forecasts
                
            }
            
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainWeatherView.collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCell else {
            fatalError("Couldn't downcast to ForecastCell")
        }
        let forecast = forecasts[indexPath.row]
        cell.configureCell(forecast: forecast)
        return cell
    }
    
    
}
