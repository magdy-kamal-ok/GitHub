//
//  GithubRepository.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GithubRepository: GenericBaseRepository<RepoItemModel, RepoCacheModel> {

    var userName:String = ""
    var offset:Int = 1

    override func getPredicate() -> NSPredicate? {
        let predicate = NSPredicate.init(format: "userName LIKE[c] %@ And offset=%i", self.userName, self.offset)
        return predicate
    }

    func getRepoList(userName: String, offset:Int)
    {
        self.userName = userName
        self.offset = offset
        var url = Constants.reposUsersApiUrl + self.userName + Constants.reposApiUrl + "\(self.offset)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.getGenericData(url: url, data: nil, headers: self.getHeaders())
    }

    override func insertDataToLocal(genericDataModel: RepoCacheModel) {
        genericDataModel.userName = self.userName
        super.insertDataToLocal(genericDataModel: genericDataModel)

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

    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        return headers
    }
}
