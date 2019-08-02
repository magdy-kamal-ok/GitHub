//
//  OwnerModel.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class OwnerModel: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photoUrl: String = ""

    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id              <- map["id"]
        name            <- map["login"]
        photoUrl        <- map["avatar_url"]

        
    }
    override class func primaryKey() -> String? {
        return "id";
    }
}
