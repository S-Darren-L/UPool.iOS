//
//  VehicleRequestViewController.swift
//  UPool
//
//  Created by Darren on 2017-05-23.
//  Copyright © 2017 UPool.iOS. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class VehicleRequestViewController: UIViewController, GMSMapViewDelegate {
    
    let geocoder = GMSGeocoder()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var googleMapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 16.0
    // The currently selected place.
    var selectedPlace: GMSPlace?
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init UI
        uiInit()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self as CLLocationManagerDelegate
        
        placesClient = GMSPlacesClient.shared()
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        googleMapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        googleMapView.settings.myLocationButton = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.scrollGestures = true
        googleMapView.settings.zoomGestures = true
        googleMapView.settings.tiltGestures = true
        googleMapView.settings.rotateGestures = true
        googleMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        googleMapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we&#39;ve got a location update.
        view.addSubview(googleMapView)
        googleMapView.isHidden = true
    }
    
    func mapView(_ googleMapView: GMSMapView, willMove gesture: Bool) {
        googleMapView.clear()
    }
    
    // Update the map once the user has made their selection.
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        // Clear the map.
        googleMapView.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
            marker.snippet = selectedPlace?.formattedAddress
            marker.map = googleMapView
        }
    }
    
    //UI init
    func uiInit(){
        self.hideKeyboardWhenTappedAround()
    }
    
    //Dismiss keyboard when Return button is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// Delegates to handle events for the location manager.
extension VehicleRequestViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: ", location)
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if googleMapView.isHidden {
            googleMapView.isHidden = false
            googleMapView.camera = camera
        } else {
            googleMapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            googleMapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: ", error)
    }
}
