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

class VehicleRequestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init UI
        uiInit()
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
    
    //Load Google map
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}
