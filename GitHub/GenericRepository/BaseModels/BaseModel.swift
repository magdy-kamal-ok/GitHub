//
//  BaseRemoteModel.swift
//  GitHub
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class BaseModel: Object, Mappable {
    

    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        

        
    }

}