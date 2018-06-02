//
//  TrackingViewController.swift
//  Truckish
//
//  Created by SUBRAT on 5/31/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import  Alamofire
import SwiftyJSON

class TrackingViewController: UIViewController {
    
    var place = Places()
    var markerr:GMSMarker!
    var updatedSource = ""
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.activityType = .automotiveNavigation
        _locationManager.distanceFilter = 10.0  // Movement threshold for new events
        //  _locationManager.allowsBackgroundLocationUpdates = true // allow in background
        
        return _locationManager
    }()

    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    
    @IBOutlet var mapHoldingView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func setUpdatedValue(source: String){
        self.destinationLabel.text = place.name
        self.sourceLabel.text =  "Your Location" //source
        self.drawPolyLine(source: source, desti: place.location)
        
        let lat = place.location.components(separatedBy: ",")[0]
        let long = place.location.components(separatedBy: ",")[1]
        self.addmarker(lat: Double(lat) ?? 0.00, Long: Double(long) ?? 0.00, name: place.name)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = "Routing Details"
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func drawPolyLine(source: String, desti: String){
        let origin = source
        let destination = desti
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyBpUS2dl7euD1iSbv4KsgURzepKek6pre8"
        
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            do {
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    
                    let polyline = GMSPolyline(path: path)
                    polyline.strokeColor = .red
                    polyline.strokeWidth = 5.0
                    polyline.map = self.mapHoldingView
                }
            }
            catch{
                print("error")
            }
        }
    }
    
    func addmarker(lat: Double, Long: Double, name: String){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: Long, zoom: 15.0)
        self.mapHoldingView.camera = camera
        let location = CLLocationCoordinate2D(latitude: lat, longitude: Long)
        self.mapHoldingView.animate(toLocation: location)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: Long)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = name
        marker.map = self.mapHoldingView
    }
    

}

extension TrackingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            self.setUpdatedValue(source: "\(lat),\(long)")
            self.addmarker(lat: Double("\(lat)") ?? 0.00, Long: Double("\(long)") ?? 0.00, name: "Your Location")
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

