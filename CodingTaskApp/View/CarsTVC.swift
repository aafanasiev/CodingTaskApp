//
//  CarsTVC.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import UIKit

class CarsTVC: UITableViewController {

    var carArray = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {

        navigationItem.title = "All Cars"
        tableView.register(UINib.init(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
    }

    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        print("Done")
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
   
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return carArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CarCell
        cell = setupCell(cell: cell, indexPath: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupCell (cell: CarCell, indexPath: IndexPath) -> CarCell {
        
        let car = carArray[indexPath.row]
        cell.carImage.loadImageUsingCacheWithUrlString(urlString: car.carImageUrl)
        cell.carName.text = car.name
        cell.carDescription.text = "\(car.make) (\(car.modelName)) - \(car.transmission.transmissionString)"
        cell.other.text = "\(car.fuelLevel.getPercentOfFuil())% - \(car.fuelType.fuelType)"
        cell.carColor.text = car.color.colorString
        
        return cell
        
    }
}




















