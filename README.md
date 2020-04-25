# Firebase Authentication Helper
## FireAuthHelper.swift

Firebase Helper to minimize code duplication in several projects and we can simply use 1 file having all the required methods to use firebase.

# How to use

1. Add your GoogleService-Info.plist file in the root directory. 
2. If you already have pod setup in your machine
   run command in your terminal 
    ```
    pod install
    ```
 
3. If you don't have pod setup. Please check [How to install CocoaPods](https://cocoapods.org/) 

# Authentication with Email and Password
You can directly use Authentication with Email and Password without making any further changes in your current project. Simply drag and drop the **FireAuthHelper.swift** file

Methods

```
- func signUpWithEmailAndPassword(email: String, password: String)
- func loginWithEmailAndPassword(email: String, password: String)
- func resetPassword(email:String)
```

# Authentication with Google
This will require to perform some steps before it work for you. Please follow [Google Sign-in](https://firebase.google.com/docs/auth/ios/google-signin) documentation. 

1. Enable Google Sign-In from Firebase Console
2. From GoogleService-Info.plist copy REVERSED_CLIENT_ID and paste it in URL Types -> URL Schema
3. In the AppDelegate file add below code
```
GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
```
and 
```
@available(iOS 9.0, *)
func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
  -> Bool {
  return GIDSignIn.sharedInstance().handle(url)
}
```
4. Set delegate on the ViewController where you want to use Sign-in with Google. And implement it's delegate methods.
```
FireAuthHelper.shared.googleDelegate = self

func googleSignInSuccess(user: User)
func googleSignInError(error: NSError)
```
5. On your button click call below method
```
FireAuthHelper.shared.signInWithGoogle()
```


### Tasks

- [x] Authentication with Email and Password
- [x] Google Authentication
- [ ] Facebook Authentication
- [ ] Twitter Authentication
