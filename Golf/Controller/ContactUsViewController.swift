//
//  ContactUsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ContactUsViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        mapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: 21.004148, longitude: 105.846233, zoom: 12.0)
        mapView.camera = camera

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.004148, longitude: 105.846233)
        marker.title = "Hanoi University of science And Technology"
        marker.snippet = "Ha Noi"
        marker.map = mapView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func drawPathFromMylocation(_ startLocation: CLLocation, to endLocation: CLLocation) {
        let origin = String(startLocation.coordinate.latitude) + "," + String(startLocation.coordinate.longitude)
        let destination = String(endLocation.coordinate.latitude) + "," + String(endLocation.coordinate.longitude)
        let params = ["origin": origin, "destination": destination, "mode": "driving", "key": apiDirection, "sensor": "true"]
      
        Alamofire.request(baseURLDirections, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            debugPrint(responseData)
            if responseData.result.value != nil {
                let json = JSON(responseData.result.value!)
                let routes = json["routes"].arrayValue
                for route in routes {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 2
                    polyline.strokeColor = .blue
                    polyline.map = self.mapView
                }
            }
        }
    }
    
    deinit {
        mapView.removeObserver(self, forKeyPath: "myLocation", context: nil)
        NotificationCenter.default.removeObserver(self)
    }
}

extension ContactUsViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        hideLoading()
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//        if !didFindMyLocation {
//            if let myLocation: CLLocation = change![NSKeyValueChangeKey.newKey] as? CLLocation {
//                mapView.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 15.0)
//                mapView.settings.myLocationButton = true
//                didFindMyLocation = true
//            }
//        }
//    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            mapView.isMyLocationEnabled = true
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let enlocation = CLLocation(latitude: 21.004148, longitude: 105.846233)
        drawPathFromMylocation(location!, to: enlocation)
    }
}
