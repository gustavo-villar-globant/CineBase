//
//  MovieDetailPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation


class MovieDetailPresenter {
    
    weak var view: MovieDetailView?
    fileprivate let router: MovieDetailRouterProtocol
    fileprivate let movie: Movie
    fileprivate let authenticationManager: AuthenticationManagerProtocol
    
    init(view: MovieDetailView, router: MovieDetailRouterProtocol, movie: Movie, authenticationManager: AuthenticationManagerProtocol = AuthenticationManager.shared) {
        self.view = view
        self.router = router
        self.movie = movie
        self.authenticationManager = authenticationManager
    }
    
    func onViewLoad() {

        let movieViewModel = MovieViewModel(title: movie.title, backdropPath: movie.backdropPath, overview: movie.overview)
        view?.display(movieViewModel)
    }
    
    func buyTickets() {
        guard let view = view else { return }
        authenticationManager.delegate = self
        authenticationManager.requestLoginWithGoogle(from: view)
    }
}

// MARK: - Authentication Manager delegate
extension MovieDetailPresenter: AuthenticationManagerDelegate {
    func authenticationManager(_ manager: AuthenticationManagerProtocol, didLoginWith user: User) {
        router.presentBuyingOptions(for: user, and: movie)
    }
}
