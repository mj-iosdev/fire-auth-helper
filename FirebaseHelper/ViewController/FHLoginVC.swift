//
//  FHLoginVC.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit

class FHLoginVC: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - UIViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        FireAuthHelper.shared.loginWithEmailAndPassword(email: self.txtEmail.text!, password: self.txtPassword.text!, success: { (user) in
            print(user.email!)
            self.redirectToProfile()
        }) { (error) in
            self.showAlert(title: "Login Error", message: error!.localizedDescription)
        }
    }
    
    @IBAction func btnSignupClicked(_ sender: Any) {
        let signupVC: FHSignupVC = self.storyboard?.instantiateViewController(identifier: "FHSignupVC") as! FHSignupVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
        let resetPasswordVC: FHResetPasswordVC = self.storyboard?.instantiateViewController(identifier: "FHResetPasswordVC") as! FHResetPasswordVC
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    //MARK: - Custom Methods
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
