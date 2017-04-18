//
//  MovieDetailPresenter.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation


class MovieDetailPresenter {
    
    weak var view: MovieDetailView?
    private let router: MovieDetailRouterProtocol
    private let movie: Movie
    
    init(view: MovieDetailView, router: MovieDetailRouterProtocol, movie: Movie) {
        self.view = view
        self.router = router
        self.movie = movie
    }
    
    func onViewLoad() {
        let movieViewModel = MovieViewModel(title: movie.title, imagePath: "", overview: movie.overview)
        view?.display(movieViewModel)
    }
    
}
