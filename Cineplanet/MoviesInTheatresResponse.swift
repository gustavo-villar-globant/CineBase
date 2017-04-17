import Foundation

protocol MovieResponseData {
    var page : Int { get }
    var results : [Movie] { get }
    var totalResults : Int { get }
    var totalPages : Int { get }
}

struct MoviesInTheatresResponse : MovieResponseData, Parseable {
    let page : Int
    let results : [Movie]
    let totalResults : Int
    let totalPages : Int
    
    init(json: NSDictionary) {
        self.page = json["page"] as? Int ?? 0
        self.totalResults = json["total_results"] as? Int ?? 0
        self.totalPages = json["total_pages"] as? Int ?? 0
        
        guard let moviesJson = json["results"] as? [NSDictionary] else {
            self.results = []
            return
        }
        
        self.results = moviesJson.enumerated().map { offset, element in Movie(json: element) }
    }
    
    init(page: Int,
         results: [Movie],
         totalResults: Int,
         totalPages: Int) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
}
