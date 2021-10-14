// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(predicate: NSPredicate) -> [Entity]
    func save(object: [Entity])
    func removeAll()
}

/// Repository
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    // MARK: - Public methods

    func get(predicate: NSPredicate) -> [Entity] {
        fatalError("")
    }

    func save(object: [Entity]) {
        fatalError("")
    }

    func removeAll() {}
}
