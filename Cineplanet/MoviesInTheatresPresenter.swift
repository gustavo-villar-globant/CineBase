import Foundation

protocol MoviesInTheatresView : class {
    func didStartRequest()
    func didFinishRequest()
    func onUpdateMovies()
    func showError(message: String)
}

final class MoviesInTheatresPresenter {
    unowned fileprivate var view : MoviesInTheatresView
    fileprivate let service : MovieService
    fileprivate var moviesData : MovieResponseData?
    var moviesInTheaters : [MovieInTheatre] {
        get { return moviesData?.results ?? [MovieInTheatre]() }
    }
    
    init(view: MoviesInTheatresView, service: MovieService) {
        self.view = view
        self.service = service
    }
    
    func listMovies() {
        self.view.didStartRequest()
        service.retrieveMovieList { [weak self] (response) in
            self?.view.didFinishRequest()
            
            switch response {
            case .failure(let error):
                self?.view.showError(message: error.localizedDescription)
                break
            case.success(let value):
                self?.updateMovies(response: value)
                break
            }
        }
    }
}

private extension MoviesInTheatresPresenter {
    func updateMovies(response: MovieResponseData) {
        moviesData = response
        self.view.onUpdateMovies()
    }
}
