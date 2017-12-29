//
//  ContactUsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import MapKit

class ContactUsViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var address: UILabel!
    
    let managerContext = StorageManager.shared.managedObjectContext
    var company: CompanyModel?
    private let storage = StorageManager.shared
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isInternetAvailable() {
            getCompany()
        } else {
            fetchCompany()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getCompany() {
        let task = CompanyModel.GetInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let companyResponse = data as? CompanyModel else {
                return
            }
            self.company = companyResponse
            let initialLocation = CLLocation(latitude: companyResponse.latitude, longitude: companyResponse.lontitude)
            self.centerMapOnLocation(location: initialLocation)
            self.showInfoCompany()
            self.saveCompany()
            
        }) { (_) in
            
        }
    }
    
    func saveCompany() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                if result.first != nil, let companyResult = result.first {
                    companyResult.company = self.company!
                    self.storage.saveContext()
                    return
                }
                self.insertCompany(companyModel: self.company!)
            }
        } catch {
            print("Failed")
        }
    }
    
    func insertCompany(companyModel: CompanyModel) {
        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: self.managerContext)
        if let companyCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? CompanyCore {
            companyCore.company = companyModel
        }
        storage.saveContext()
    }
    
    func fetchCompany() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                if let companyCore = result.first {
                    company = companyCore.company
                    let initialLocation = CLLocation(latitude: (company?.latitude)!, longitude: (company?.lontitude)!)
                    centerMapOnLocation(location: initialLocation)
                    showInfoCompany()
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    func showInfoCompany() {
        let artwork = Artwork(title: (company?.name)!,
                              locationName: "",
                              discipline: "",
                              coordinate: CLLocationCoordinate2D(latitude: (company?.latitude)!, longitude: (company?.lontitude)!))
        mapView.addAnnotation(artwork)
        phone.text = company?.phone.description
        website.text = company?.website
        address.text = company?.adress
    }
    
    @IBAction func pressedShowPath(_ sender: Any) {
        let lat = company?.latitude.description
        let lon = company?.lontitude.description
        let directionsURL = "http://maps.apple.com/?daddr=\(lat!),\(lon!)"
        debugPrint(directionsURL)
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
