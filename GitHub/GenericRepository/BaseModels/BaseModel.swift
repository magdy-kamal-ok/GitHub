//
//  BaseModel.swift
//  GitHub
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


extension RemoteMappable where Self: Mappable
{
    
}

class BaseModel: Object, RemoteMappable {
    

    required convenience public init?(map: Map) {
        self.init()
    }
    
    required convenience init?(dict: [String:Any]) {
        self.init()
    }
    func mapping(map: Map) {
        
    }

}
