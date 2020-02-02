//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by Matthew Ramos on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class MainWeatherView: UIView {
    
    
    public lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "City Name"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var zipCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a Zip Code"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 400, height: 400)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemTeal
        return cv
    }()
    
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray
        tf.text = "00000"
        tf.textAlignment = .center
        return tf
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupLabels()
        setupCollectionview()
        setupTextField()
        
    }

    private func setupCollectionview() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:cityNameLabel.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -150),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 150)
        ])
    }
    
    private func setupLabels() {
        addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            
//            zipCodeLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
//            zipCodeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            zipCodeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
