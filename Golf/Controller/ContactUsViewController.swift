//
//  ContactUsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import GoogleMaps

class ContactUsViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 21.004148, longitude: 105.846233, zoom: 12.0)
        mapView.camera = camera
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.004148, longitude: 105.846233)
        marker.title = "Hanoi University \nof science And Technology"
        marker.snippet = "Ha Noi"
        marker.map = mapView
    }
}
