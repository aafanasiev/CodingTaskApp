//
//  CarInterface.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import Foundation

protocol CarInterface: NSObjectProtocol {

    func getCar(cars: [Car])
    func error(error: String)
    
}
