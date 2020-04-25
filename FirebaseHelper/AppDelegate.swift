//
//  AppDelegate.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

        FireAuthHelper.shared.currentUser(success: { (user) in
            self.redirectToProfile()
        }) {
            self.redirectToLogin()
        }
        
        return true
    }

    func redirectToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC: FHLoginVC = storyboard.instantiateViewController(identifier: "FHLoginVC") as! FHLoginVC
        let navigationController = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func redirectToProfile() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC: FHProfileVC = storyboard.instantiateViewController(identifier: "FHProfileVC") as! FHProfileVC
        let navigationController = UINavigationController(rootViewController: profileVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

}

