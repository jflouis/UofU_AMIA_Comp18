//
//  ViewController.swift
//  Location_Based_Application
//
//  Created by JANETTE VAZQUEZ on 5/31/18.
//  Copyright © 2018 JANETTE VAZQUEZ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var map: MKMapView!
    //map connect
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //array to store location
        let location = locations[0]
        //zoom in on users location
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        
        let loc:CLLocation = CLLocation(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let ceo:CLGeocoder = CLGeocoder()
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    
                    print("reverse geocode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.postalCode)
                }
        })
        
    }
    
    func requestLocationAccess(){
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            manager.requestWhenInUseAuthorization()
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        
        manager.delegate = self
        //option - can make it larger or lower
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //triggers location permission dialog - will only appear once
        manager.requestWhenInUseAuthorization()
        //api called to trigger one time location request
        manager.startUpdatingLocation()
    
    }


}

