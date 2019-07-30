//
//  RepoCacheModel.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RepoCacheModel: BaseModel {


    @objc dynamic var userName: String = ""
    @objc dynamic var offset: Int = 0 {
        didSet {
            compoundKey = compoundKeyValue()
        }
    }
    
    @objc dynamic var id: Int = 0 {
        didSet {
            compoundKey = compoundKeyValue()
        }
    }
    
    var reposList: List<RepoItemModel> = List<RepoItemModel>()
    @objc dynamic var compoundKey: String = ""

    required convenience public init?(map: Map) {
        self.init()
    }

    override func mapping(map: Map) {


    }

    override class func primaryKey() -> String? {
        return "compoundKey";
    }

    private func compoundKeyValue() -> String {
        return "\(id)-\(offset)"
    }



}
