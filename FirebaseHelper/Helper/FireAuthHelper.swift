//
//  FireAuthHelper.swift
//  FirebaseHelper
//
//  Created by Orange on 23/04/20.
//  Copyright © 2020 orange. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

protocol FireAuthHelperGoogleDelegate: NSObjectProtocol {
    func googleSignInSuccess(user: User)
    func googleSignInError(error: NSError)
}

protocol FireAuthHelperFacebookDelegate: NSObjectProtocol {
}

class FireAuthHelper: NSObject {
    
    static let shared = FireAuthHelper()
    weak var googleDelegate: FireAuthHelperGoogleDelegate?
    
    override init(){
        super.init()
    }
    
}

//MARK: - Email and Password

extension FireAuthHelper {
    
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
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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

//MARK: - Google Signin

extension FireAuthHelper: GIDSignInDelegate {
    
    func signInWithGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signInWithGoogleCredentials(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
                    self.googleDelegate?.googleSignInError(error: authError)
                } else {
                    print(error.localizedDescription)
                    self.googleDelegate?.googleSignInError(error: authError)
                    //self.showMessagePrompt(error.localizedDescription)
                    return
                }
                // ...
                return
            } else {
                self.googleDelegate?.googleSignInSuccess(user: authResult!.user)
            }
            // User is signed in
            // ...
        }
        
    }
    
    //MARK: - GIDSignInDelegate
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {

    }

    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
        self.signInWithGoogleCredentials(credential: credential)
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    
}
