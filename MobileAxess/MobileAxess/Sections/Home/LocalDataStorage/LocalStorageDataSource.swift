//
//  LocalStorageDataSource.swift
//  MobileAxess
//
//  Created by Anuj Vats on 27/09/20.
//  Copyright © 2020 Anuj Vats. All rights reserved.
//




import Foundation
import RealmSwift

// Interface for the Local Data Storage
class LocalStorageDataSource {
    
    static let shared = LocalStorageDataSource()

    private let realm: Realm

    init() {
        self.realm = try! Realm()
    }

      
    func insertItemsLocalDataSource(_ itemModels: [RealmItemModel], completion: @escaping (MAErrorStatus?) -> Void) {
           do {
               try realm.write {
                   realm.add(itemModels.compactMap { $0 }, update: .all)
                   completion(nil)
               }
           } catch {
            completion(MAErrorStatus(error: .dataBaseFailure))
           }
    }

    func fetchItemsLocalDataSource(completion: @escaping ([RealmItemModel]) -> Void) {

            let itemModels =  realm.objects(RealmItemModel.self)
            completion(Array(itemModels))
    }


}


