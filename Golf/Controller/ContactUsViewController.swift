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
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var showpath = false
    var company: CompanyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        drawMaker()
        showInfoCompany()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func drawMaker() {
        mapView.delegate = self
        company = CompanyModel(name: "hanoi university of seience and technology", adress: "so 1 dai co viet", website: "www.hust.edu.vn", phone: "842436231732", latitude: 21.0062876, lontitude: 105.8423921, info: "alo alo")
        let camera = GMSCameraPosition.camera(withLatitude: (company?.latitude)!, longitude: (company?.lontitude)!, zoom: 15.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (company?.latitude)!, longitude: (company?.lontitude)!)
        marker.title = "Hanoi University of Science and Technology"
        marker.snippet = "Ha Noi"
        marker.map = mapView
        mapView.isMyLocationEnabled = true
    }
    
    func showInfoCompany() {
        phone.text = company?.phone
        website.text = company?.website
        address.text = company?.adress
        infoLabel.text = company?.info
    }
    
    @IBAction func pressedShowPath(_ sender: Any) {
        if !showpath {
            mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
            showpath = true
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func drawPathFromMylocation(_ startLocation: CLLocation, to endLocation: CLLocation) {
        let origin = String(startLocation.coordinate.latitude) + "," + String(startLocation.coordinate.longitude)
        let destination = String(endLocation.coordinate.latitude) + "," + String(endLocation.coordinate.longitude)
        let params = ["origin": origin,
                      "destination": destination,
                      "mode": "driving",
                      "key": apiDirection,
                      "sensor": "true"]
      
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
        if showpath {
            mapView.removeObserver(self, forKeyPath: "myLocation", context: nil)
        }
        NotificationCenter.default.removeObserver(self)
    }
}

extension ContactUsViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        hideLoading()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if !didFindMyLocation {
            if let myLocation: CLLocation = change![NSKeyValueChangeKey.newKey] as? CLLocation {
                mapView.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 13.0)
                didFindMyLocation = true
            }
        }
    }
    
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
        let endLocation = CLLocation(latitude: (company?.latitude)!, longitude: (company?.lontitude)!)
        drawPathFromMylocation(location!, to: endLocation)
    }
}
