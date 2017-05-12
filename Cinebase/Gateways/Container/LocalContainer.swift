//
//  LocalContainer.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol LocalContainer: class {
    
    associatedtype Model
    associatedtype ModelID
    
    func find(withID id: ModelID, completion: @escaping (Result<Model>) -> Void)
    func add(_ model: Model, completion: @escaping (Result<Void>) -> Void)
    func update(_ model: Model, completion: @escaping (Result<Void>) -> Void)
    func delete(_ model: Model, completion: @escaping (Result<Void>) -> Void)
    
    func fetchAll(completion: @escaping (Result<[Model]>) -> Void)
    func deleteAll(completion: @escaping (Result<Void>) -> Void)
    
}

struct NotFoundInContainerError: LocalizedError { }
