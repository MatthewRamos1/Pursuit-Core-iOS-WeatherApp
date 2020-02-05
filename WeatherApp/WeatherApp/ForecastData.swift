//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let daily: Daily
    let timezone: String
}

struct Daily: Codable {
    let data: [Forecast]
}

struct Forecast: Codable {
    let temperatureHigh: Double
    let temperatureLow: Double
    let time: Int
    let icon: String
}
