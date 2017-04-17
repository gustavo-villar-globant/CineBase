import Foundation

protocol MovieInTheatre {
    var movieID: NSNumber { get }
    var posterPath: String { get }
    var title: String { get }
}

extension Movie: MovieInTheatre {}
