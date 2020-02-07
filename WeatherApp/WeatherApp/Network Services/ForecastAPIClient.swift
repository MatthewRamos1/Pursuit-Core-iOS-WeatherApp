//
//  ForecastAPIClient.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct ForecastAPIClient {
    static func fetchForecasts(coordinates: String, completion: @escaping (Result<ForecastData, AppError>) -> ()) {
        let endPointUrl = "https://api.darksky.net/forecast/a1233ac866774ca908ace8b05587b8ae/\(coordinates)"
        guard let url = URL(string: endPointUrl) else {
            completion(.failure(.badURL(endPointUrl)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
                    completion(.success(forecastData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
                
            }
        }
        
    }
    
    static func fetchPictures (query: String, completion: @escaping (Result<[Picture], AppError>) -> ()) {
        let endPointURL = "https://pixabay.com/api/?key=14980906-543f47e356fbfc99d3efe2dfe&q=\(query)"
        guard let url = URL(string: endPointURL) else {
            completion(.failure(.badURL(endPointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(PictureData.self, from: data)
                    let pictures = results.hits
                    completion(.success(pictures))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
