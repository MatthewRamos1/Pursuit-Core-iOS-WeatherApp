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
    
    private var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        view.backgroundColor = .white
        mainWeatherView.collectionView.dataSource = self
        mainWeatherView.collectionView.delegate = self
        mainWeatherView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")
    }
    
    override func loadView() {
        view = mainWeatherView
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainWeatherView.collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath)
        let forecast = forecasts[indexPath.row]
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}
