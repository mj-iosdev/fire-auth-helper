//
//  FireAuthHelper.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit
import Firebase


class FireAuthHelper: NSObject {
    
    static let shared = FireAuthHelper()
    
    override init(){}
    
    // Signup with Email and Password
    // Returns User object or Error
    func signUpWithEmailAndPassword(email: String, password: String, success: @escaping (_ user: User) -> (), andFailure failure: @escaping (NSError?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                failure(err as NSError)
            } else {
                success(authResult!.user)
            }
        }
    }
    
    // Update extra data after user signup
    // Returns success or Error
    func updateCurrentUserValue(name: String, age: String, success: @escaping () -> (), andFailure failure: @escaping (NSError?) -> ()) {
        if let current_user = Auth.auth().currentUser?.createProfileChangeRequest() {
            current_user.displayName = name
            //current_user.setValue(age, forKey: "age")
            
            current_user.commitChanges { (error) in
                if let err = error {
                    failure(err as NSError)
                } else {
                    success()
                }
            }
        }
    }
    
    // Login user with Email and Password
    // Returns User object or Error
    func loginWithEmailAndPassword(email: String, password: String, success: @escaping (_ user: User) -> (), andFailure failure: @escaping (NSError?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                failure(err as NSError)
            } else {
                success(authResult!.user)
            }
        }
    }
    
    // Logs out current user
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.redirectToLogin()
        } catch {
            print("Signup error")
        }
    }
    
    // Get Current user
    func currentUser(success: @escaping (_ user: User) -> (), andFailure failure: @escaping () -> ()) {
        if let current_user = Auth.auth().currentUser {
            success(current_user)
        } else {
            failure()
        }
    }
    
    // Reset Password Email
    func resetPassword(email:String, success: @escaping () -> (), andFailure failure: @escaping (NSError?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let err = error {
                failure(err as NSError)
            } else {
                success()
            }
        }
    }
}
