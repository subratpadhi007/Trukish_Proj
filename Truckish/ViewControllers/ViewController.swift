//
//  ViewController.swift
//  Truckish
//
//  Created by SUBRAT on 5/30/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ObjectMapper


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    let GOOGLE_API_KEY = "AIzaSyBpUS2dl7euD1iSbv4KsgURzepKek6pre8"
    
    var ref: DatabaseReference?
    var dbHandel: DatabaseHandle?

    var allPlaces : Array<Places>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        //To read the data
        ViewUtils.addActivityView(view: self.view)
        Database.database().reference().child("places").observe(.value, with: { (snap) in
            ViewUtils.removeActivityView(view: self.view)
            self.allPlaces = Mapper<Places>().mapArray(JSONObject: snap.value)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, withCancel: nil)
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navItems()
    }
    
    @objc func logoutButtonPressed(){
        Dialog.showDialog(viewController: self, title: "LogOut", message: "Are you sure wnat to logout ?") {
            if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
                appdelegate.showLoginScreen()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cnt = self.allPlaces?.count{
            return cnt
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.cellView.dropShadow()
        if let plc = self.allPlaces?[indexPath.row]{
            cell.titleLabel.text = plc.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let plc = self.allPlaces?[indexPath.row]{
            vc.place = plc
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func barItemWithView(view: UIView, rect: CGRect) -> UIBarButtonItem {
        let container = UIView(frame: rect)
        container.addSubview(view)
        view.frame = rect
        return UIBarButtonItem(customView: container)
    }
    func navItems(){
        
        let home: UIButton = UIButton(type: UIButtonType.custom)
        home.setImage(UIImage(named: "logout"), for: UIControlState.normal)
        home.imageView?.contentMode = .scaleAspectFit
        home.addTarget(self, action: #selector(self.logoutButtonPressed), for: UIControlEvents.touchUpInside)
        let rightBar = barItemWithView(view: home, rect: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.navigationItem.setRightBarButtonItems([ rightBar], animated: true)
        self.navigationItem.title = "Places List"
        
    }

}

class ListCell: UITableViewCell{
    
    @IBOutlet var cellView: UIView!
    @IBOutlet var titleLabel: UILabel!
}
