//
//  GithubRepository.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class GithubRepository: GenericBaseRepository<RepoItemModel, RepoCacheModel> {
    
    var userName:String = ""
    var offset:Int = 1
    
    override func getPredicate() -> NSPredicate? {
        let predicate = NSPredicate.init(format: "userName LIKE[c] %@ And offset=%i", self.userName, self.offset)
        return predicate
    }
    
    func getRepoList(userName:String, offset:Int)
    {
        self.userName = userName
        self.offset = offset
        let repoApiComponents = ReposApiComponets.init(name: self.userName, offset: self.offset)
        self.getGenericData(apiComponents: repoApiComponents)
    }
    
    override func insertDataToLocal(genericDataModel: RepoCacheModel) {
        genericDataModel.userName = self.userName
        super.insertDataToLocal(genericDataModel: genericDataModel)
        
    }
    
    override func handleResponseData(_ responseObj: [BaseModel]) {
        self.insertList(remote: responseObj as! [RepoItemModel])
        
    }
    
    override func insertList(remote: [RepoItemModel]) {
        if remote.count > 0
        {
            let repoCache = RepoCacheModel.init()
            if let owner = remote.first?.owner
            {
                repoCache.id = owner.id
            }
            repoCache.userName = self.userName
            repoCache.offset = self.offset
            let repoList = List<RepoItemModel>()
            repoList.append(objectsIn: remote)
            repoCache.reposList = repoList
            self.insertDataToLocal(genericDataModel: repoCache)
        }
        
    }
    
}
