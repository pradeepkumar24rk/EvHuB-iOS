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

class MapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let mapViewModel = MapViewModel()
    let userDefaults = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        pinHubLocation()
    }
    
    @IBAction func AddLocationHubHandler(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPinViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func FindNearestHub(_ sender: Any) {
        mapViewModel.findShorestDistanceHub { route in
            guard let route = route else { return }
            self.map.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func pinHubLocation() {
        for locationAddress in userDefaults.locationAddresses {
            CLGeocoder().geocodeAddressString(locationAddress) { placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location, let titleName = placemark.name {
                    // Create a custom annotation
                    let customPin = CustomAnnotation(title: titleName, subtitle: locationAddress, coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                    self.map.addAnnotation(customPin)
                } else {
                    print("Not able to find the location")
                }
            }
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Location access denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let userLocation = location.coordinate
            mapViewModel.userLocation = userLocation
            print("User Location: \(userLocation.latitude), \(userLocation.longitude)")
            map.showsUserLocation = true
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
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
}
