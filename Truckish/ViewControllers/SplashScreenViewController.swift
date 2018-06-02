//
//  SplashScreenViewController.swift
//  Truckish
//
//  Created by SUBRAT on 6/1/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet var ImageHolderView: UIImageView!
    @IBOutlet var rippleView: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.ImageHolderView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        var config = UIView.RippleConfiguration(color: UIColor.bdefaultColor)
        config.scaleAnimateDuration = 0.6
        rippleView.rippleAnimate(with: config, completionHandler: {
            //            print("ripple!!")
        })
        
        UIView.animate(withDuration: 0.75, animations: { () -> Void in
            self.ImageHolderView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: {(completed) -> Void in
            if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                let delayTime = DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    appdelegate.showLoginScreen()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
