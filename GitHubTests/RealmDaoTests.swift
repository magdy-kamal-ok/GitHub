//
//  RealmDaoTests.swift
//  GitHubTests
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RealmSwift
@testable import GitHub

class RealmDaoTests: XCTestCase {

    var testRealm: Realm!

    override func setUp() {

        do {
            var realmConfiguration = Realm.Configuration.init()
            realmConfiguration.inMemoryIdentifier = "realmTest"
            testRealm = try Realm(configuration: realmConfiguration)

        } catch (let error) {
            fatalError(error.localizedDescription)
        }
    }

    override func tearDown() {
        testRealm = nil
    }

    func testInsertAndFetchRepoItemModel()
    {
        let sut = RealmDao.init(realm: testRealm)
        let repoItemModel = RepoItemModel.init()
        repoItemModel.id = 4000
        sut.insert(genericDataModel: repoItemModel)
        let predicate = NSPredicate.init(format: "id=%i", 4000)
        let savedRepoItemModel = sut.fetch(predicate: predicate, type: RepoItemModel.self)
        XCTAssertEqual(savedRepoItemModel?.id, 4000)
    }
    func testInsertAndFetchOwnerModel()
    {
        let sut = RealmDao.init(realm: testRealm)
        let ownerModel = OwnerModel.init()
        ownerModel.name = "owner"
        ownerModel.photoUrl = "https://www.myphoto.com/myphoto"
        sut.insert(genericDataModel: ownerModel)
        let predicate = NSPredicate.init(format: "name=%@", "owner")
        let savedOwnerModel = sut.fetch(predicate: predicate, type: OwnerModel.self)
        XCTAssertEqual(savedOwnerModel?.name, "owner")
        XCTAssertEqual(savedOwnerModel?.photoUrl, "https://www.myphoto.com/myphoto")
    }

    func testInsertAndFetchRepoCacheModel()
    {
        let sut = RealmDao.init(realm: testRealm)
        let repoCacheModel = RepoCacheModel.init()
        repoCacheModel.userName = "user"
        sut.insert(genericDataModel: repoCacheModel)
        let predicate = NSPredicate.init(format: "userName=%@", "user")
        let savedRepoCacheModel = sut.fetch(predicate: predicate, type: RepoCacheModel.self)
        XCTAssertEqual(savedRepoCacheModel?.userName, "user")
    }

}
