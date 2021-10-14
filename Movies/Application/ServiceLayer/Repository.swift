// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RepositoryProtocol {
    func save<Model>(object: [Model], movieType: Int?, id: Int?)
    func get<Model>(movieType: Int?, id: Int?) -> [Model]?
    func removeAll()
}

final class Repository: RepositoryProtocol {
    private var database: RepositoryProtocol?

    init(database: RepositoryProtocol) {
        self.database = database
    }

    func save<Model>(object: [Model], movieType: Int?, id: Int?) {
        database?.save(object: object, movieType: movieType, id: id)
    }

    func get<Model>(movieType: Int?, id: Int?) -> [Model]? {
        database?.get(movieType: movieType, id: id)
    }

    func removeAll() {
        database?.removeAll()
    }
}

final class RealmService: RepositoryProtocol {
    func save<Model>(object: [Model], movieType: Int?, id: Int?) {
        print(0)
    }

    func get<Model>(movieType: Int?, id: Int?) -> [Model]? {
        nil
    }

    func removeAll() {}
}
