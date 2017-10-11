//
//  Car.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import Foundation

class Car: NSObject {
    
    private var _id: String?
    private var _modelIdentifier: String?
    private var _modelName: String?
    private var _name: String?
    private var _make: String?
    private var _group: String?
    private var _color: String?
    private var _series: String?
    private var _fuelType: String?
    private var _fuelLevel: Float?
    private var _transmission: String?
    private var _licensePlate: String?
    private var _latitude: Double?
    private var _longitude: Double?
    private var _innerCleanliness: String?
    private var _carImageUrl: String?
    
    init(id: String, modelIdentifier: String, modelName: String, name: String, make: String, group: String, color: String, series: String, fuelType: String, fuelLevel: Float, transmission: String, licensePlate: String, latitude: Double, longitude: Double, innerCleanliness: String, carImageUrl: String) {
        self._id = id
        self._modelIdentifier = modelIdentifier
        self._modelName = modelName
        self._name = name
        self._make = make
        self._group = group
        self._color = color
        self._series = series
        self._fuelType = fuelType
        self._fuelLevel = fuelLevel
        self._transmission = transmission
        self._licensePlate = licensePlate
        self._latitude = latitude
        self._longitude = longitude
        self._innerCleanliness = innerCleanliness
        self._carImageUrl = carImageUrl
    }
    
    var id: String {
        get {
            return _id ?? ""
        }
    }
    var modelIdentifier: String {
        get {
            return _modelIdentifier ?? ""
        }
    }
    var modelName: String {
        get {
            return _modelName ?? ""
        }
    }
    var name: String {
        get {
            return _name ?? ""
        }
    }
    var make: String {
        get {
            return _make ?? ""
        }
    }
    var group: String {
        get {
            return _group ?? ""
        }
    }
    var color: String {
        get {
            return _color ?? ""
        }
    }
    var series: String {
        get {
            return _series ?? ""
        }
    }
    var fuelType: String {
        get {
            return _fuelType ?? ""
        }
    }
    var fuelLevel: Float {
        get {
            return _fuelLevel ?? 0
        }
    }
    var transmission: String {
        get {
            return _transmission ?? ""
        }
    }
    var licensePlate: String {
        get {
            return _licensePlate ?? ""
        }
    }
    var latitude: Double {
        get {
            return _latitude ?? 0
        }
    }
    var longitude: Double {
        get {
            return _longitude ?? 0
        }
    }
    var innerCleanliness: String {
        get {
            return _innerCleanliness ?? ""
        }
    }
    var carImageUrl: String {
        get {
            return _carImageUrl ?? ""
        }
    }
}
