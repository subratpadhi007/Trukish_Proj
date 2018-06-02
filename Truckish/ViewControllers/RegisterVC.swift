//
//  RegisterVC.swift
//  Truckish
//
//  Created by SUBRAT on 6/1/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet var registerButnOutlet: UIButton!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.title = "Register User"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButnClicked(_ sender: Any) {
        if let cnt = self.email.text?.count, cnt > 3{
            if let cnt2 = self.password.text?.count, cnt2 > 1{
                Auth.auth().createUser(withEmail: self.email.text ?? "", password: self.password.text ?? "") { (authResult, error) in
                    if let _ = authResult{
                        Dialog.showOk(viewController: self, title: "Success", message: "Your are registered successfully. Please login.", okAction: {
                            if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
                                appdelegate.showLoginScreen()
                            }
                        })
                    }else{
                        Dialog.showOk(viewController: self, title: "Error", message: "Registration unsuccessful. Please try after some time.", okAction: {
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
    
    @IBAction func dismissTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
