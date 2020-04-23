//
//  FHResetPasswordVC.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit

class FHResetPasswordVC: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var txtEmail: UITextField!

    //MARK: - UIViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reset Password"
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction
    @IBAction func btnResetPasswordClicked(_ sender: Any) {
        FireAuthHelper.shared.resetPassword(email: self.txtEmail.text!, success: {
            self.showAlert(title: "Reset", message: "Reset email sent")
        }) { (error) in
            self.showAlert(title: "Reset Error", message: error!.localizedDescription)
        }
    }
    
    //MARK: - Custom Methods

    func showAlert(title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
