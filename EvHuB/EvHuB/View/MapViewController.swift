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
    @IBOutlet weak var profileLogo: UIImageView!
    @IBOutlet weak var bottomRightBtn: UIImageView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var currentLoctionBtn: UIImageView!
    
    let locationManager = CLLocationManager()
    let mapViewModel = MapViewModel()
    let userDefaults = UserDefaultsManager.shared
    var userInfo: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.designView()
        locationManager.delegate = self
        map.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        bottomRightBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightBtnHandler)))
        bottomRightBtn.layer.cornerRadius = 20
        currentLoctionBtn.layer.cornerRadius = 20
        profileLogo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileLogoBtnHandle)))
        currentLoctionBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currentLocationBtnHandler)))
        guard let val = userInfo?.admin else { return }
        if val {
            bottomRightBtn.image = UIImage(named: "addPin")
        }
        self.pinHubLocation()
    }
    // MARK: - RIGHT BTN
    @objc func rightBtnHandler() {
        guard let val = userInfo?.admin else { return }
        if val {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPinViewController") as? AddPinViewController else { return }
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            mapViewModel.findShorestDistanceHub { route in
                guard let route = route else { return }
                self.map.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.map.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    //MARK: - PROFILE
    @objc func profileLogoBtnHandle() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EVProfileViewController") as? EVProfileViewController else { return }
        vc.userInfo = self.userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - CURRENT LOCATION
    @objc func currentLocationBtnHandler() {
        if let userLocation = locationManager.location?.coordinate {
            // User's location is available, center the map on it
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            map.setRegion(region, animated: true)
        } else {
            // User's location is not available, start updating location to obtain it
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateLocation(with location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
    }
// MARK: - PIN DISPLAY
    func pinHubLocation() {
        for locationAddress in userDefaults.locationAddresses {
            CLGeocoder().geocodeAddressString(locationAddress.address) { placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location {
                    // Create a custom annotation
                    let customPin = CustomAnnotation(title: locationAddress.name, subtitle: locationAddress.address, coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
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
        // MARK: -  CURRENT LOCATION
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
    // MARK: - ANNOTATION
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CustomAnnotation {
            let customPinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
            customPinView.image = UIImage(named: "pinLoc")
            customPinView.contentMode = .center
            customPinView.canShowCallout = true
            return customPinView
        }
        return nil
    }
    // MARK: - ROUTE
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let title = view.annotation?.title, let subtitle = view.annotation?.subtitle {
            let data = HubModel(name: title ?? "", address: subtitle ?? "")
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EVAnnotationViewController") as? EVAnnotationViewController {
                vc.hubInfo = data
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
// MARK: - ADD NEW PIN
extension MapViewController: AddPinDelegate {
    func addPin(_ data: HubModel) {
        userDefaults.locationAddresses.append(data)
        CLGeocoder().geocodeAddressString(data.address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                // Create a custom annotation
                let customPin = CustomAnnotation(title: data.name, subtitle: data.address, coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                self.map.setRegion(region, animated: true)
                self.map.addAnnotation(customPin)
            } else {
                print("Not able to find the location")
            }
        }
    }
}
