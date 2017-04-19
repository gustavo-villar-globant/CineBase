import UIKit

final class LoginManagerViewController: UIViewController {
    fileprivate var presenter : LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FirebaseLoginPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatePresentedController()
    }
    
    func signOut() {
        presenter.signOut()
    }
    
    func presentLogin() {
        let loginViewController = presenter.initialLoginViewController() as! UINavigationController
       
        loginViewController.setNavigationBarHidden(true, animated: true)
        present(loginViewController, animated: true, completion: nil)
    }
}

extension LoginManagerViewController : LoginView {
    func loginStateDidChange(user: UserBasicInfo?) {
        updatePresentedController()
    }
    
    fileprivate func updatePresentedController() {
        guard presenter.currentUser == nil else {
            performSegue(withIdentifier: "PresentMovies", sender: nil)
            return
        }
        
        presentLogin()
    }
}
