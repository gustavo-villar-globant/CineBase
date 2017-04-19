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
    
    init(view: MovieDetailView, router: MovieDetailRouterProtocol, movie: Movie) {
        self.view = view
        self.router = router
        self.movie = movie
    }
    
    func onViewLoad() {
        let movieViewModel = MovieViewModel(title: movie.title, imagePath: "", overview: movie.overview)
        view?.display(movieViewModel)
    }
    
    func buyTickets() {
        guard let view = view else { return }
        AuthenticationManager.shared.delegate = self
        AuthenticationManager.shared.requestLoginWithGoogle(from: view)
    }
}

// MARK: - Authentication Manager delegate
extension MovieDetailPresenter: AuthenticationManagerDelegate {
    func authenticationManager(_ manager: AuthenticationManager, didLoginWith user: User) {
        router.presentBuyingOptions(for: user, and: movie)
    }
}
