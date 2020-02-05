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
    private var defaultZip = "11423"
    override func loadView() {
        view = mainWeatherView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        view.backgroundColor = .white
        mainWeatherView.collectionView.dataSource = self
        mainWeatherView.collectionView.delegate = self
        mainWeatherView.textField.delegate = self
        getForecasts(zipcode: defaultZip)
        
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
            case .success(let coordinatesRaw):
                
                coordinates = "\(coordinatesRaw.lat),\(coordinatesRaw.long)"
                print(coordinates)
                
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecast = forecasts[indexPath.row]
        navigationController?.pushViewController(WeatherDetailController(), animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let query = textField.text {
        getForecasts(zipcode: query)
        }
        return true
    }
}
