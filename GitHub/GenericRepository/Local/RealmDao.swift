//
//  RealmDao.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift


extension Object: Storable
{
    
}

class RealmDao: GenericDataLocalSource {
    


    var realm: Realm!
    
    init(realm:Realm) {
        self.realm = realm
    }
    
    func fetch<L>(predicate: NSPredicate?, type: L.Type) -> L? where L : Storable {
        do {
            if let predicate = predicate
            {
                let objects = self.realm.objects(type as! Object.Type)
                return objects.filter(predicate).first as? L
            }
            else
            {
                let objects = self.realm.objects(type as! Object.Type)
                
                return objects.first as? L
            }
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    func insert<L>(genericDataModel: L) where L : Storable {
        do {
            realm.beginWrite()
            realm.add(genericDataModel as! Object, update: true)
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
    

    

}
