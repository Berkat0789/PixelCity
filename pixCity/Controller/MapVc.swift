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

class MapVc: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
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

    }//end view did load

//--Protocol Related Functions
    
    
//---Actions
    @IBAction func centerLocationPressed(_ sender: Any) {
    }
    
//---Gestures and Animations
    
//---Selectors
    
//---View update Function
   
}//end controller
