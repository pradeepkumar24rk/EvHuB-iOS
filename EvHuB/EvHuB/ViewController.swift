//
//  ViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 19/10/23.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the location manager
        locationManager.delegate = self
        
        // Request permission for location access
        locationManager.requestWhenInUseAuthorization()
        
        // Start updating the location
        locationManager.startUpdatingLocation()
    }
    
    func updateMap(with location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // Location access granted, start updating location
            locationManager.startUpdatingLocation()
        } else {
            // Handle the case where the user denied location access
            // You might want to show an alert asking the user to enable location services
            print("Location access denied")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let userLocation = location.coordinate
            print("User Location: \(userLocation.latitude), \(userLocation.longitude)")
            updateMap(with: userLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
