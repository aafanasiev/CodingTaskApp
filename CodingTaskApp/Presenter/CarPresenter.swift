//
//  CarPresenter.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CarPresenter {
    
    private let baseUrl = "http://www.codetalk.de/cars.json"
    private let headers: HTTPHeaders = ["Content-Type": "application/json"]
    private var carArray = [Car]()
    
    weak private var carInterface: CarInterface?
    
    init(carInterface: CarInterface) {
        self.carInterface = carInterface
    }
    
    func getAllCars() {
        
        let url = URL(string: baseUrl)!
        _ = Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            guard let json = response.result.value else {
                self.carInterface?.error(error: "Error")
                return
            }
            
            let swiftyJson = JSON(json).arrayValue
            self.carArray = swiftyJson.map({ (carObject) -> Car in
                return carObject.createCar()
            })
            
            self.carInterface?.getCar(cars: self.carArray)
        })
    }
}

extension JSON {
    
    func createCar() -> Car {
        
        let id = self["id"].stringValue
        let modelIdentifier = self["modelIdentifier"].stringValue
        let modelName = self["modelName"].stringValue
        let name = self["name"].stringValue
        let make = self["make"].stringValue
        let group = self["group"].stringValue
        let color = self["color"].stringValue
        let series = self["series"].stringValue
        let fuelType = self["fuelType"].stringValue
        let fuelLevel = self["fuelLevel"].stringValue
        let transmission = self["transmission"].stringValue
        let licensePlate = self["licensePlate"].stringValue
        let latitude = self["latitude"].stringValue
        let longitude = self["longitude"].stringValue
        let innerCleanliness = self["innerCleanliness"].stringValue
        let carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier)/\(color)/2x/car.png"
       
       
        let car = Car(id: id,
                      modelIdentifier: modelIdentifier,
                      modelName: modelName,
                      name: name,
                      make: make,
                      group: group,
                      color: color,
                      series: series,
                      fuelType: fuelType,
                      fuelLevel: Float(fuelLevel) ?? 0,
                      transmission: transmission,
                      licensePlate: licensePlate,
                      latitude: Double(latitude) ?? 0,
                      longitude: Double(longitude) ?? 0,
                      innerCleanliness: innerCleanliness,
                      carImageUrl: carImageUrl)
        
        return car
    }
    
}

extension String {
    var colorString: String {
        let stringArray = self.components(separatedBy: .punctuationCharacters)
        return stringArray.map{"\($0.first!)".uppercased() + "\($0.dropFirst())" }.joined(separator: " ")
    }
    
}
