//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityDateLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    var forecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
