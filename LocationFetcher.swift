//
//  LocationFetcher.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 16/05/2025.
//

import CoreLocation
import Foundation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    var lastKnownPosition: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownPosition = locations.first?.coordinate
    }
}
