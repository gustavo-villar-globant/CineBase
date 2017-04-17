import Foundation

typealias MoviesInTheatresResponseHandler = (NetworkResult<MovieResponseData>) -> Void

protocol MovieService {
    func retrieveMovieList(completion: @escaping MoviesInTheatresResponseHandler)
}
