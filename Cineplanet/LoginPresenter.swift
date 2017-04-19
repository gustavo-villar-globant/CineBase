import Foundation
import UIKit

protocol LoginView :class {
    func loginStateDidChange(user: UserBasicInfo?)
}

protocol LoginPresenter {
    var currentUser : UserBasicInfo? { get }
    init(view: LoginView)
    func initialLoginViewController() -> UIViewController
    func signOut()
}
