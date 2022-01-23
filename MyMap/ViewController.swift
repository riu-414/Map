//
//  ViewController.swift
//  MyMap
//
//  Created by 大杉祐弥 on 2022/01/13.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var dispMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inputTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let seachkey = textField.text {
            print(seachkey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(seachkey , completionHandler: { (placemarks, error) in
                
                if let unwrapPlacemark = placemarks {
                    
                    if let firstPlacemark = unwrapPlacemark.first {
                        
                        if let location = firstPlacemark.location {
                            
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                            
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoordinate
                            
                            pin.title = seachkey
                            
                            self.dispMapView.addAnnotation(pin)
                            
                            self.dispMapView.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
            
        }
        return true
    }
   
    @IBAction func changeMapButton(_ sender: Any) {
        if dispMapView.mapType == .standard {
            dispMapView.mapType = .satellite
            print(1)
            
        } else if dispMapView.mapType == .satellite {
            dispMapView.mapType = .hybrid
            print(2)
            
        } else if dispMapView.mapType == .hybrid {
            dispMapView.mapType = .satelliteFlyover
            print(3)
            
        } else if dispMapView.mapType == .satelliteFlyover {
            dispMapView.mapType = .hybridFlyover
            print(4)
            
        } else if dispMapView.mapType == .hybridFlyover  {
            dispMapView.mapType = .mutedStandard
            print(5)
            
        } else {
            dispMapView.mapType = .standard
            print(6)

        }
        
        
    }
    
}

