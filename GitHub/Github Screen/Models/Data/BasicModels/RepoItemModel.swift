//
//  RepoItemModel.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RepoItemModel: BaseModel {

    @objc dynamic var id: Int = 0
    @objc dynamic var repoTitle: String = ""
    @objc dynamic var repoUrl: String = ""
    @objc dynamic var repoDesc: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var forkCount: Int = 0
    @objc dynamic var creationDate: String = ""
    @objc dynamic var owner: OwnerModel?
    
    required convenience public init?(map: Map) {
        self.init()
    }

    override func mapping(map: Map) {

        id              <- map["id"]
        repoTitle       <- map["name"]
        repoUrl         <- map["html_url"]
        repoDesc        <- map["description"]
        language        <- map["language"]
        forkCount       <- map["forks_count"]
        creationDate    <- map["created_at"]
        owner           <- map["owner"]

    }
    override class func primaryKey() -> String? {
        return "id";
    }
}
