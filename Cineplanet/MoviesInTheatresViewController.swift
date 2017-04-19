import Foundation
import UIKit

class MoviesInTheatresViewController : UIViewController {
    @IBOutlet var tableView : UITableView!
    fileprivate let cellIdentifier = "cellIdentifier"
    fileprivate var presenter : MoviesInTheatresPresenter!
    fileprivate var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesInTheatresPresenter(view: self as MoviesInTheatresView,
                                              service: MovieServiceImp())
        presenter.listMovies()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func onSignOut() {
        let parent = self.navigationController?.presentingViewController as! LoginManagerViewController
        
        parent.signOut()
        self.dismiss(animated: true, completion: nil)
    }
}

extension MoviesInTheatresViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesInTheaters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        let movie = presenter.moviesInTheaters[indexPath.row]
        
        cell.textLabel?.text = movie.title
        return cell
    }
}

extension MoviesInTheatresViewController : MoviesInTheatresView {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    func onUpdateMovies() {
        tableView.reloadData()
    }
    
    func didStartRequest() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func didFinishRequest() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
