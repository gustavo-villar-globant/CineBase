import Foundation
import UIKit
import FirebaseAuthUI
import FirebaseAuth
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI

extension FIRUser : UserBasicInfo {}

class FirebaseLoginPresenter : NSObject, LoginPresenter {
    fileprivate let firAuth : FIRAuth! = FIRAuth.auth()
    fileprivate let firAuthUI : FUIAuth! = FUIAuth.defaultAuthUI()
    fileprivate var authStateDidChangeHandle: FIRAuthStateDidChangeListenerHandle?
    unowned fileprivate let view : LoginView
    var currentUser : UserBasicInfo? {
        return firAuth.currentUser
    }
    
    required init(view: LoginView) {
        self.view = view
        super.init()
        configureFUIAuth()
    }
    
    deinit {
        guard let handle = authStateDidChangeHandle else { return }
        
        firAuth.removeStateDidChangeListener(handle)
    }
    
    func initialLoginViewController() -> UIViewController {
        return firAuthUI.authViewController()
    }
    
    func signOut() {
        try! firAuth.signOut()
    }
}

extension FirebaseLoginPresenter : FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        guard let authError = error else { return }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }
    }
}

//MARK: FUIAuth Configurations
private extension FirebaseLoginPresenter {
    func configureFUIAuth() {
        firAuthUI?.providers = listAuthProviders()
        firAuthUI?.isSignInWithEmailHidden = false
        firAuthUI?.delegate = self
        authStateDidChangeHandle = firAuth.addStateDidChangeListener({ [weak self] (auth, user) in
            self?.view.loginStateDidChange(user: user)
        })
    }
    
    func listAuthProviders() -> [FUIAuthProvider] {
        return [
            FUIGoogleAuth(),
        ]
    }
}
