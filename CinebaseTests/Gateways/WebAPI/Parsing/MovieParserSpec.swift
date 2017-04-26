//
//  MovieParserSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Cinebase

class MovieParserSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("a Movie Parser") {
            var sut: MovieParser!
            beforeEach {
                sut = MovieParser(baseURL: "")
            }
            
            context("when it parses a correctly formed json array") {
                var jsonArray: [[String: Any]]!
                beforeEach {
                    let jsonReader = JSONFileReader(fileName: "NowPlaying")
                    jsonArray = try! jsonReader.json() as! [[String: Any]]
                }
                
                it("should create a Movie array") {
                    expect(sut.parseArray(fromJSONArray: jsonArray).value).toNot(beNil())
                }
            }
            
            context("when it parses a json with no id") {
                var json: [String: Any]!
                beforeEach {
                    json = [
                        "title": "Some title",
                        "overview": "Not recommended",
                        "poster_path": "/some_movie_poster.jpeg"
                    ]
                }
                it("should fail") {
                    expect(sut.parse(fromJSON: json).value).to(beNil())
                }
            }
            
            context("when it parses a json with no title") {
                var json: [String: Any]!
                beforeEach {
                    json = [
                        "id": 123456,
                        "overview": "Not recommended",
                        "poster_path": "/some_movie_poster.jpeg"
                    ]
                }
                it("should fail") {
                    expect(sut.parse(fromJSON: json).value).to(beNil())
                }
            }
            
            context("when it parses a json with no id") {
                var json: [String: Any]!
                beforeEach {
                    json = [
                        "id": 123456,
                        "title": "Some title",
                        "poster_path": "/some_movie_poster.jpeg"
                    ]
                }
                it("should fail") {
                    expect(sut.parse(fromJSON: json).value).to(beNil())
                }
            }
        }
        
    }
    
}
