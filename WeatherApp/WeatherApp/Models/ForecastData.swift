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
    
    func returnCity() -> String {
        let seperateStrings = timezone.components(separatedBy: "/")
        guard let cityName = seperateStrings.last else {
            return timezone
        }
        return cityName
    }
}

struct Daily: Codable {
    let data: [Forecast]
}

struct Forecast: Codable {
    let temperatureHigh: Double
    let temperatureLow: Double
    let time: Int
    let icon: String
    let summary: String
    
    func unixToDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
