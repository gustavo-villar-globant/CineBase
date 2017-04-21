//
//  AuthenticationManager.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

protocol LoginView: class {
    func presentLogin(_ loginViewController: UIViewController)
}

protocol AuthenticationManagerDelegate: class {
    func authenticationManager(_ manager: AuthenticationManager, didLoginWith user: User)
    func authenticationManager(_ manager: AuthenticationManager, didFailLoginWith error: Error)
}

extension AuthenticationManagerDelegate {
    func authenticationManager(_ manager: AuthenticationManager, didFailLoginWith error: Error) { }
}

class AuthenticationManager: NSObject {
    
    static let shared = AuthenticationManager()
    fileprivate weak var loginView: LoginView?
    weak var delegate: AuthenticationManagerDelegate?
    
    private override init() {
        super.init()
    }
    
    func setup() {
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = AuthenticationManager.shared
        GIDSignIn.sharedInstance().uiDelegate = AuthenticationManager.shared
    }
    
    func requestLoginWithGoogle(from viewController: LoginView) {
        self.loginView = viewController
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    func handle(_ url: URL, sourceApplication: String?) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: [:])
    }
    
}

// MARK: - Google Sign in
extension AuthenticationManager: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present loginViewController: UIViewController!) {
        self.loginView?.presentLogin(loginViewController)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        guard let authentication = user.authentication else {
            self.delegate?.authenticationManager(self, didFailLoginWith: error!)
            return
        }
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (firebaseUser, error) in
            
            guard let firebaseUser = firebaseUser else {
                self.delegate?.authenticationManager(self, didFailLoginWith: error!)
                return
            }
            
            let user = User(userID: firebaseUser.uid,
                            name: firebaseUser.displayName ?? "",
                            imagePath: firebaseUser.photoURL?.absoluteString)
            self.delegate?.authenticationManager(self, didLoginWith: user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
