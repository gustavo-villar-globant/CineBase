//
//  MovieEntitySpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/5/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Quick
import Nimble
@testable import Cinebase
import RealmSwift

class MovieEntitySpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("a Movie Entity") {
            
            var sut: MovieEntity!
            var realm: Realm!
            
            beforeEach {
                sut = MovieEntity()
                sut.movieID = -1234
                sut.title = "Guardians of the Galaxy"
                sut.overview = "Set to the backdrop of Awesome Mixtape #2, 'Guardians of the Galaxy Vol. 2' continues the team's adventures as they unravel the mystery of Peter Quill's true parentage."
                sut.imagePath = "/guardians_poster.jpeg"
                sut.backdropPath = "/backdrop_guardians.png"
                
                let realmConfigurator = RealmConfigurator()
                realm = try! realmConfigurator.makeRealm(on: .temporal, named: "Movies")
                
            }
            
            it("should be different than other movies") {
                let otherMovie = MovieEntity()
                expect(sut).toNot(equal(otherMovie))
            }
            
            context("when is saved") {
                beforeEach {
                    try! realm.write {
                        realm.deleteAll()
                        realm.add(sut)
                    }
                }
                it("should retrieve the same values") {
                    let retrievedMovie = realm.objects(MovieEntity.self).filter("movieID == -1234").first
                    expect(sut).to(equal(retrievedMovie))
                }
            }
            
        }
        
    }
    
}
