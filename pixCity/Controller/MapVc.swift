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

class MapVc: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
//---Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var pullUpViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    //--Variables and Arrays
    let locationManager = CLLocationManager()
    let locationAuthStatus = CLLocationManager.authorizationStatus()
    let locationCoordinateRadius: Double = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        mapView.delegate = self
        locationManager.delegate = self
        AuthorizeLocationService()
        addDoubleTap()
        spinner.isHidden = true
        progressLabel.isHidden = true

    }//end view did load

//--Protocol Related Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageService.instance.images.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? photoCell {
            let imageIndex = ImageService.instance.images[indexPath.row]
            let image = UIImageView(image: imageIndex)
            cell.addSubview(image)
            return cell
        } else {
        return UICollectionViewCell()
        }
    }
    
    
//---Actions
    @IBAction func centerLocationPressed(_ sender: Any) {
        if locationAuthStatus == .authorizedAlways || locationAuthStatus == .authorizedWhenInUse {
            UpdateUserLocation()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
//---Gestures and Animations
    func SlideDownView() {
        let taptoSlide = UITapGestureRecognizer(target: self, action: #selector(SlideDown(_:)))
        self.mapView.addGestureRecognizer(taptoSlide)
    }
    func SlideUpView() {
        pullUpViewHeight.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        spinner.startAnimating()
        spinner.isHidden = false
        progressLabel.isHidden = false
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.delegate = self
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)
    }
    
//---Selectors
    @objc func dropPin(sender: UITapGestureRecognizer) {
        removeDuplicatePin()
        SlideUpView()
        SlideDownView()
        let tapPoint = sender.location(in: mapView)
        let tapCoordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordianate: tapCoordinate, identifier: "droppablePin")
        let annotationRadius = MKCoordinateRegionMakeWithDistance(tapCoordinate, locationCoordinateRadius * 2.0, locationCoordinateRadius * 2.0)
        mapView.addAnnotation(annotation)
        mapView.setRegion(annotationRadius, animated: true)
        
       print(FlickrAURL(annotation: annotation, ApiKEy: API_KEY, NumberoFPhotos: 40))
        ImageService.instance.getImageURLS(annotation: annotation) { (complete) in
            if complete {
                ImageService.instance.getImages(completed: { (done) in
                    if done {
                        self.collectionView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        self.progressLabel.isHidden = true
                        self.progressLabel.text = "\(ImageService.instance.images.count)/40 images Loaded"

                    }
                })
            }
        }
    }
    @objc func SlideDown(_ Recon: UITapGestureRecognizer) {
        pullUpViewHeight.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
//---View update Function
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }else {
            let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
            pinAnnotation.tintColor = #colorLiteral(red: 0.5098039216, green: 0.6117647059, blue: 1, alpha: 1)
            pinAnnotation.animatesDrop = true
            return pinAnnotation
        }
    }
    func removeDuplicatePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
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
