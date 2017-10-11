//
//  MainVC.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import UIKit
import MapKit

class MainVC: UIViewController {

    @IBOutlet weak var carMapView: MKMapView!
    @IBOutlet weak var listImage: UIImageView!
    
    private var carArray = [Car]()
    private var presenter: CarPresenter?
    private var infoController: CarInfo!
    private var stateInfoScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = CarPresenter(carInterface: self)
        presenter?.getAllCars()
        
        carMapView.delegate = self
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCarInfo(notification:)), name: .carNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeInfoScreen(notification:)), name: .closeNotification, object: nil)

        setupView()
    }

    func setupView() {
        
        let listGesture = UITapGestureRecognizer(target: self, action: #selector(goToList))
        listImage.addGestureRecognizer(listGesture)
        listImage.isUserInteractionEnabled = true
        
        listImage.layer.shadowColor = UIColor.black.cgColor
        listImage.layer.shadowOpacity = 1
        listImage.layer.shadowOffset = CGSize.zero
        listImage.layer.shadowRadius = 10
        
        // I used the coordinates of Munich here, but in a real project I will use the current coordinates using Core Location
        let coordinateMunich = CLLocationCoordinate2D(latitude: 48.137683, longitude: 11.57135)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinateMunich, span: span)
        carMapView.setRegion(region, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // The method which pass cars' array to Table View Controller
    @objc
    func goToList() {
        
        let navVC = storyboard?.instantiateViewController(withIdentifier: "navigationControllerCarTVC") as? UINavigationController
        let carTVC = navVC?.viewControllers.first as! CarsTVC
        carTVC.carArray = carArray
        self.present(navVC!, animated: true, completion: nil)
    }
    
    // The method which check info Controller's state and if it's true, it close info Controller.
    @objc
    func closeInfoScreen(notification: Notification) {
        
        if stateInfoScreen {
            infoController.view.removeFromSuperview()
            stateInfoScreen = !stateInfoScreen
        }
    }
    
    // The method of adding annotations to MapView
    func addAnnotations(cars: [Car]) {
        
        _ = cars.map({ (car) -> Void in
            let coordinate = CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.subtitle = car.id
            carMapView.addAnnotation(annotation)
        })
    }
    
    @objc
    func showCarInfo(notification: Notification) {
        
        guard let dict = notification.userInfo as? Dictionary<String, Any>, let id = dict["id"] as? String else {
            return
        }
        
        let car = carArray.filter{$0.id == id}.first
        
        if !stateInfoScreen {
            infoController = self.storyboard?.instantiateViewController(withIdentifier: "carInfoVC") as? CarInfo
                infoController.car = car
                
                self.view.addSubview(infoController.view)
                self.addChildViewController(infoController)
                let sizeScreen = view.frame.size
                
                infoController.view.frame = CGRect(x: 0, y: sizeScreen.height, width: sizeScreen.width, height: sizeScreen.height)
                UIView.animate(withDuration: 0.3) {
                    self.infoController.view.frame = CGRect(x: 0, y: sizeScreen.height * 0.75, width: sizeScreen.width, height: sizeScreen.height)
                }
                stateInfoScreen = !stateInfoScreen
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainVC: CarInterface {
    
    func getCar(cars: [Car]) {
        self.carArray = cars
        addAnnotations(cars: self.carArray)
    }
    
    func error(error: String) {
        
        let errorAlert = UIAlertController(title: "Attantion", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

extension MainVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let carId = view.annotation?.subtitle else {
            return
        }
        
        let dictionary = ["id" : carId ?? ""]
        NotificationCenter.default.post(name: .carNotification, object: nil, userInfo: dictionary)

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        let  annotationIdentifier = "AnnotationIdentfier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = false
            annotationView.image = UIImage(named: "annotation")
        }

        return annotationView
    }
    
}

extension Notification.Name {
    static let carNotification = Notification.Name("carNotification")
    static let closeNotification = Notification.Name("closeNotification")
}
