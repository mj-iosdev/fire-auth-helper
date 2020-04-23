//
//  FHProfileVC.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit

class FHProfileVC: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    //MARK: - UIViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.getCurrentUser()
    }
    
    //MARK: - IBAction

    @IBAction func btnLogoutClicked(_ sender: Any) {
        FireAuthHelper.shared.logoutUser()
    }
    
    //MARK: - Custom Methods
    func getCurrentUser() {
        FireAuthHelper.shared.currentUser(success: { (user) in
            self.txtName.text = user.displayName
            self.txtEmail.text = user.email
        }) {
            FireAuthHelper.shared.logoutUser()
        }
    }
    
}
