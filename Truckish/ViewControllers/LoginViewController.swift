//
//  LoginViewController.swift
//  Truckish
//
//  Created by SUBRAT on 5/31/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButnOutlet: UIButton!
    
    @IBOutlet var registerButnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = "Login User"
    }
    
    @IBAction func loginButnClicked(_ sender: Any) {
        
        if let cnt = self.email.text?.count, cnt > 3{
            if let cnt2 = self.password.text?.count, cnt2 > 1{
                ViewUtils.addActivityView(view: self.view)
                Auth.auth().signIn(withEmail: self.email.text ?? "", password: self.password.text ?? "") { (user, error) in
                    ViewUtils.removeActivityView(view: self.view)
                    if let _ = user{
                        if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
                            appdelegate.showHomeScreen()
                        }
                    }else{
                        Dialog.showOk(viewController: self, title: "Error", message: "There is no user record corresponding to this identifier. The user may have been deleted. Please Register.", okAction: {
                        })
                    }
                }
            }else{
                Dialog.showOk(viewController: self, title: "Error", message: "Password can't be blank.", okAction: {
                    
                })
            }
        }else{
            Dialog.showOk(viewController: self, title: "Error", message: "Email must be greater then 3 charachtr.", okAction: {
            })
        }
        
    }
    
    @IBAction func registerUserButnClicked(_ sender: Any) {
    }

}
