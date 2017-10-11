//
//  CarInfo.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import UIKit

class CarInfo: UIViewController {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carTransmission: UILabel!
    @IBOutlet weak var fuelInfo: UILabel!
    @IBOutlet weak var closeBtn: UIImageView!
    
    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeCarInfo))
        closeBtn.addGestureRecognizer(closeGesture)
        closeBtn.isUserInteractionEnabled = true
        
        if let car = car {
            carName.text = car.name
            carModel.text = "\(car.make) \(car.modelName)"
            carTransmission.text = car.transmission.transmissionString
            fuelInfo.text = "\(car.fuelLevel.getPercentOfFuil())% - \(car.fuelType.fuelType)"
            carImage.loadImageUsingCacheWithUrlString(urlString: car.carImageUrl)
            
        }
    }
    
    @objc
    func closeCarInfo() {

        NotificationCenter.default.post(name: .closeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}


extension Float {
    
    func getPercentOfFuil() -> Int{
        return Int(self * 100)
    }
}

extension String {
    
    var transmissionString: String {
        return self == "M" ? "Manual" : "Automatic"
    }
    
    var fuelType: String {
        switch self {
        case "P":
            return "Petrol"
        case "D":
            return "Diesel"
        default:
            return "Electric"
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            }
            }.resume()
    }
}
