//
//  MapVc.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVc: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    
//---Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
//--Variables and Arrays
    let locationManager = CLLocationManager()
    let locationAuthStatus = CLLocationManager.authorizationStatus()
    let locationCoordinateRadius: Double = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        AuthorizeLocationService()

    }//end view did load

//--Protocol Related Functions
    
    
//---Actions
    @IBAction func centerLocationPressed(_ sender: Any) {
        if locationAuthStatus == .authorizedAlways || locationAuthStatus == .authorizedWhenInUse {
            UpdateUserLocation()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
//---Gestures and Animations
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.delegate = self
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)
    }
    
//---Selectors
    @objc func dropPin(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: mapView)
        let tapCoordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        
        
    }
    
//---View update Function
    func UpdateUserLocation() {
        guard let userCoordinate = locationManager.location?.coordinate else {return}
        let userCoordinateRadius = MKCoordinateRegionMakeWithDistance(userCoordinate, locationCoordinateRadius * 2.0, locationCoordinateRadius * 2.0)
        mapView.setRegion(userCoordinateRadius, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        UpdateUserLocation()
    }
    func AuthorizeLocationService() {
        if locationAuthStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
   
}//end controller
