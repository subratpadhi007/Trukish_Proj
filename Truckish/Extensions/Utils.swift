//
//  Utils.swift
//  Truckish
//
//  Created by SUBRAT on 6/1/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 0)
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 5
    }
}

extension UIButton{
    func dropShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
}

extension  UIColor {
    
    open class var bdefaultColor: UIColor {
        get {
            return UIColor(red:0.50, green:0.87, blue:0.92, alpha:1.0)
        }
    }
}

class Dialog{
    static func showDialog (viewController: UIViewController,title: String, message: String, okAction:@escaping () -> Void){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            okAction()
        })
        let NoAction = UIAlertAction(title: "No", style: .default, handler: { (alert) in
            
        })
        alertView.addAction(YesAction)
        alertView.addAction(NoAction)
        viewController.present(alertView, animated: true, completion: nil)
    }
    static func showOk (viewController: UIViewController,title: String, message: String, okAction:@escaping () -> Void){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Okya", style: .default, handler: { (alert) in
            okAction()
        })
        alertView.addAction(YesAction)
        viewController.present(alertView, animated: true, completion: nil)
    }
}


struct ViewUtils {
    
    // Activity Indicator
    static let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    static func removeActivityView(view : UIView) {
        let window = UIApplication.shared.keyWindow!
        window.viewWithTag(111)?.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    static func addActivityView(view : UIView) {
        
        let window = UIApplication.shared.keyWindow!
        window.viewWithTag(111)?.removeFromSuperview()
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: window.frame.size.width , height: window.frame.size.height + 80 )
        loadingView.clipsToBounds = true
        loadingView.tag = 111
        activityView.frame = CGRect(x: loadingView.frame.size.width/2 , y: loadingView.frame.size.height / 2, width: 100, height: 100)
        activityView.layer.cornerRadius = 10
        activityView.center = view.center
        activityView.tintColor = UIColor.bdefaultColor
        
        
        
        activityView.backgroundColor = UIColor.bdefaultColor
        
        view.isUserInteractionEnabled = false
        activityView.startAnimating()
        loadingView.addSubview(activityView)
        window.addSubview(loadingView)
        
    }
}





