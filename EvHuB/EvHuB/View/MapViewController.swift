//
//  ViewController.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 19/10/23.
//

import UIKit
import CoreLocation
import MapKit

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}

class MapViewController: UIViewController {
    
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
        
        // For accuracy location which is geocoded
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        map.delegate = self
    }
    
    func updateMap(with location: CLLocationCoordinate2D) {
//        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
//        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
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
        
        CLGeocoder().geocodeAddressString("Pla Plaza, 8, Old Bypass Rd, Karur, Tamil Nadu 639001") { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                // Create the pin
//                let pin = MKPointAnnotation()
//                pin.coordinate = location.coordinate
//                pin.title = "hello here"
//                self.map.addAnnotation(pin)
//                self.map.setCenter(location.coordinate, animated: true)
                
                // Create a custom annotation
                let customPin = CustomAnnotation(title: "Custom Pin Title", subtitle: "Custom Pin Subtitle", coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))

                // Add the custom annotation to the map view
                self.map.addAnnotation(customPin)
                
            } else {
                print("Not able to find the location")
            }
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CustomAnnotation {
            let customPinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
            customPinView.image = UIImage(named: "pinLoc")
            customPinView.canShowCallout = true
            return customPinView
        }
        return nil
    }

}
