//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import AVFoundation
import DataPersistence
import ImageKit

let dataPersistence = DataPersistence<ImageObject>(filename: "images.plist")

class WeatherDetailController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityDateLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    let test = "new"
    var forecast: Forecast?
    private var selectedImage: UIImage?
    var pictures = [Picture]() {
        didSet {
            guard let picture = pictures.randomElement() else {
                fatalError("Error with picture function")
            }
        
            weatherImageView.getImage(with: picture.largeImageURL) { [weak self] (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.weatherImageView.image = UIImage(systemName: "gear")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.weatherImageView.image = image
                        self?.selectedImage = image
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        guard let detailForecast = forecast else {
            fatalError("Couldn't access forecast")
        }
        cityDateLabel.text = String(detailForecast.time)
        weatherStatusLabel.text = detailForecast.summary
        ForecastAPIClient.fetchPictures(query: test) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Couldn't access PictureData: \(appError)")
                }
            case .success(let pictures):
                DispatchQueue.main.async {
            self?.pictures = pictures
                }
            }
        }
    }
    
    func returnCity(string: String) -> String {
        let seperateStrings = string.components(separatedBy: "/")
        guard let cityName = seperateStrings.last else {
            return string
        }
        return cityName
    }
    
    func createImageObject(image: UIImage) -> ImageObject? {
        guard let image = selectedImage else {
            return nil
        }
        let size = UIScreen.main.bounds.size
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        print(imageObject)
        return imageObject
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = selectedImage else {
            fatalError("Couldn't get image")
        }
        guard let imageObject = createImageObject(image: image) else {
            fatalError("Couldn't get image object")
        }
        do {
            try dataPersistence.createItem(imageObject)
            showAlert(title: "Action Complete", message: "Your file was saved.")
        } catch {
            fatalError("Couldn't create item")
        }
    }
}
