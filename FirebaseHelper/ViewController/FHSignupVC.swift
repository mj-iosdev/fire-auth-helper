//
//  FBSignupVC.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit

class FHSignupVC: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - UIViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Signup"
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction
    
    @IBAction func btnSignupClicked(_ sender: Any) {
        
        FireAuthHelper.shared.signUpWithEmailAndPassword(email: self.txtEmail.text!, password: self.txtPassword.text!, success: { (user) in
            self.setData(name: self.txtName.text!, age: self.txtAge.text!)
        }) { (error) in
            self.showAlert(title: "Signup Error", message: error!.localizedDescription)
        }
    }
    
    //MARK: - Custom Methods
    func setData(name: String, age: String) {
        FireAuthHelper.shared.updateCurrentUserValue(name: name, age: age, success: {
            self.redirectToProfile()
        }) { (error) in
            self.showAlert(title: "Data Error", message: error!.localizedDescription)
        }
    }
    
    func redirectToProfile() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.redirectToProfile()
    }
    
    func showAlert(title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
