//
//  ImageObject.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct ImageObject: Writable {
  let imageData: Data
  let date: Date
  let identifier = UUID().uuidString
    
}
