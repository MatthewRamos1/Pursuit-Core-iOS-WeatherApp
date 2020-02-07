//
//  PictureData.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

typealias Writable = Codable & Equatable

struct PictureData: Writable {
    let hits: [Picture]
}

struct Picture: Writable {
    let largeImageURL: String
}
