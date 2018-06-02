//
//  DetailViewController.swift
//  Truckish
//
//  Created by SUBRAT on 5/31/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var showButnOutlet: UIButton!
    @IBOutlet var mapHolderView: GMSMapView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weatherButnOutlet: UIButton!
    
    
    var place = Places()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButnOutlet.dropShadow()
        weatherButnOutlet.dropShadow()
        
        
        self.nameLabel.text = place.name
        self.descriptionLabel.text = place.desc
        
        
        let lat = place.location.components(separatedBy: ",")[0]
        let long = place.location.components(separatedBy: ",")[1]
        self.addMarkerOnMap(lat: Double(lat) ?? 0.00, Long: Double(long) ?? 0.00)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "More Details"
    }
    
    func addMarkerOnMap(lat: Double, Long: Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: Long, zoom: 15.0)
        self.mapHolderView.camera = camera
        let location = CLLocationCoordinate2D(latitude: lat, longitude: Long)
        self.mapHolderView.animate(toLocation: location)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: Long)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = place.name
        marker.map = self.mapHolderView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showButnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackingViewController") as! TrackingViewController
        vc.place = self.place
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
