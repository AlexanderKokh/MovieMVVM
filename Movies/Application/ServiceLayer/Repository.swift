// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(predicate: NSPredicate) -> [Entity]?
    func save(object: [Entity])
    func removeAll()
    func createPredicate(movieID: String) -> NSPredicate
}

///
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    func get(predicate: NSPredicate) -> [Entity]? {
        fatalError("")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("")
    }

    func createPredicate(movieID: String) -> NSPredicate {
        fatalError("")
    }

    func removeAll() {}
}

final class RealmRepository<RealmEntity: Object>: Repository<RealmEntity> {
    typealias Entity = RealmEntity

    override func save(object: [Entity]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
}
