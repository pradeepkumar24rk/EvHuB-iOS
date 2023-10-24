//
//  MapViewModel.swift
//  EvHuB
//
//  Created by PraDeePKuMaR RaJaRaM on 24/10/23.
//

import Foundation
import MapKit

class MapViewModel {
    let userDefaults = UserDefaultsManager.shared
    
    var routes: [MKRoute] = []
    var userLocation: CLLocationCoordinate2D?
    
    func findShorestDistanceHub(completionHandler: @escaping (MKRoute?) -> Void){
        routes = []
        findRoutes { statusBool in
            if statusBool {
                let min = self.routes.min { r1, r2 in
                    return r1.distance < r2.distance
                }
                completionHandler(min)
            }
        }
    }
    
    func findRoutes(completionHandler: @escaping(Bool) -> Void) {
        guard let userLoc = userLocation else { return }
        let sourcePlacemark = MKPlacemark(coordinate: userLoc)
        var destinationPlacemark: MKPlacemark?
        let dispatchGroup = DispatchGroup() // Use a dispatch group to track completion
        
        for location in userDefaults.locationAddresses {
            dispatchGroup.enter() // Enter the dispatch group
            
            CLGeocoder().geocodeAddressString(location) { placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location {
                    destinationPlacemark = MKPlacemark(coordinate: location.coordinate)
                    guard let desPlacemark = destinationPlacemark else {
                        dispatchGroup.leave() // Leave the dispatch group
                        return
                    }
                    let directionRequest = MKDirections.Request()
                    directionRequest.source = MKMapItem(placemark: sourcePlacemark)
                    directionRequest.destination = MKMapItem(placemark: desPlacemark)
                    directionRequest.transportType = .automobile

                    let directions = MKDirections(request: directionRequest)
                    directions.calculate { (response, error) in
                        guard let response = response else {
                            if let error = error {
                                print("Error calculating directions: \(error.localizedDescription)")
                            }
                            dispatchGroup.leave() // Leave the dispatch group
                            return
                        }
                        let route = response.routes[0]
                        self.routes.append(route)
                        dispatchGroup.leave() // Leave the dispatch group
                    }
                } else {
                    dispatchGroup.leave() // Leave the dispatch group
                }
            }
        }
        
        // Notify completionHandler after all routes have been calculated
        dispatchGroup.notify(queue: .main) {
            completionHandler(true)
        }
    }
}
