import Foundation

protocol MovieResponseData {
    var page : Int { get }
    var results : [Movie] { get }
    var totalResults : Int { get }
    var totalPages : Int { get }
}
