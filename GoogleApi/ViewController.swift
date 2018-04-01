//
//  ViewController.swift
//  GoogleApi
//
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationAuthorization()
        
        // set camera position with given coords
        let camera = GMSCameraPosition.camera(withLatitude: 41.85, longitude: -87.65, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        showCurrentLocationOnMap(mapView: mapView)
        //testMarkers(mapView: mapView)
        view = mapView
        
    }
    
    func getLocationAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func showCurrentLocationOnMap(mapView: GMSMapView) {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            print("Starting location update")
            locationManager.startUpdatingLocation()
            
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    
    func testMarkers(mapView: GMSMapView) {
        
        // Create marker in center of map
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 43, longitude: -88)
        marker.title = "Center"
        marker.snippet = "America"
        marker.map = mapView
        
        let markerTwo = GMSMarker()
        markerTwo.position = CLLocationCoordinate2D(latitude: 44, longitude: -89)
        markerTwo.title = "Not far from center"
        markerTwo.snippet = "USA"
        markerTwo.map = mapView
    }


}

