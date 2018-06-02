//
//  WahterVC.swift
//  Truckish
//
//  Created by SUBRAT on 6/1/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import ObjectMapper
import SwiftyJSON

class WeahterVC: UIViewController {

    @IBOutlet var selectionlabel: UILabel!
    @IBOutlet var outerView: UIView!
    
    @IBOutlet var weatherView: UIView!
    @IBOutlet var wind: UILabel!
    @IBOutlet var cloud: UILabel!
    @IBOutlet var geoCord: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var tempMin: UILabel!
    @IBOutlet var temp_Max: UILabel!
    
    let dropDown = DropDown()
    
    let url1 = "http://api.openweathermap.org/data/2.5/weather?q="
    let url2 = ",IN&appid=7d5375b0acf5a1e7c70d0c1aad5a6299"
    
    var listOfCities = ["Bangalore","Kolkata","Mumbai","Delhi","Chennai","Hyderabad","Pune","Patna","Ranchi","Jaipur"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outerView.layer.cornerRadius = 10
        outerView.layer.borderWidth = 1
        outerView.layer.borderColor = UIColor.bdefaultColor.cgColor
        
        
        weatherView.layer.cornerRadius = 10
        weatherView.layer.borderWidth = 1
        weatherView.layer.borderColor = UIColor.bdefaultColor.cgColor
        weatherView.dropShadow()

        self.selectionlabel.text = self.listOfCities[0]
        self.dropDown.anchorView = self.outerView
        self.dropDown.dataSource = self.listOfCities
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            DispatchQueue.main.async {
                self.selectionlabel.text = item
                self.callWeahterData()
            }
        }
        dropDown.dismissMode = .onTap
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callWeahterData(){
        self.getWeahterData { (dt, err) in
            if let e = err{
                Dialog.showOk(viewController: self, title: "Error", message: e.localizedDescription, okAction: {
                })
            }else{
                if let d = dt as? String{
                    let cd = Mapper<Weather_model>().map(JSONString: d)
                    self.updateValue(input: cd)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = "Weahter Forcast"
        self.callWeahterData()
    }
    
    func updateValue(input: Weather_model?){
        
        self.wind.text = String(describing: input?.wind?.speed ?? 0.00) + " m/s"
        var allWeahter = [String]()
            input?.weather?.forEach({ (we) in
                allWeahter.append(we.desc)
            })
        self.cloud.text = allWeahter[0]
        self.pressure.text = String(describing: input?.main?.pressure ?? 0) + " hpa"
        self.humidity.text = String(describing: input?.main?.humidity ?? 0) + " %"
        self.geoCord.text = String(describing: input?.coord?.lat ?? 0.00) + ", " + String(describing: input?.coord?.lon ?? 0.00)
        self.tempMin.text = String(describing: input?.main?.temp_min ?? 0.00)
        self.temp_Max.text = String(describing: input?.main?.temp_max ?? 0.00)
    }
    
    @IBAction func dropDownButnClick(_ sender: Any) {
        dropDown.show()
    }
    
    func getWeahterData(callback: @escaping (_ data: Any?, _ err: NSError?)-> ()){
        let url = url1 + self.selectionlabel.text! + url2
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    if let dt = json.rawString() {
                        callback(dt,nil)
                    }
                case .failure(let error):
                    let error = NSError(domain: "",
                                        code: 400, //Set your own error code if required
                        userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    callback(nil, error)
                }
        }
        
        
    }

}
