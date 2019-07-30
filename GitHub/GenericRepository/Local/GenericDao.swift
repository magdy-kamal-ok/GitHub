//
//  GenericDao.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class GenericDao<R:Object>: GenericDataLocalSource {

    var realm: Realm!
    
    init(realm: Realm) {

        self.realm = realm
    }
    func insert(genericDataModel: R) {
        do {
            realm.beginWrite()
            realm.add(genericDataModel, update: true)
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }


    func fetch(predicate: NSPredicate?) -> R? {
        do {
            if let predicate = predicate
            {
                return realm.objects(R.self).filter(predicate).first
            }
            else
            {
                return realm.objects(R.self).first
            }
        } catch (let error) {
            print(error)
            return nil
        }
    }


    func delete() {
        do {
            realm.beginWrite()
            realm.delete(realm.objects(R.self))
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
}
