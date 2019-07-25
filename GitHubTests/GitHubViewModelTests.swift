//
//  GitHubViewModelTests.swift
//  GitHubTests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import GitHub

class GitHubViewModelTests: XCTestCase {

    var sut: GithubViewModel!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = GithubViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testGetListOfRepos()
    {

        let expectation = XCTestExpectation.init(description: "get repos List")
        var responseResult: [RepoItemModel]!
        sut.observableGithubRepoList.subscribe({ (subObj) in

            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(_):
                expectation.fulfill()
            case .completed:
                print("Completed")
            }

        }).disposed(by: disposeBag)
        sut.getReposWith(text: "john")
        wait(for: [expectation], timeout: 10)
        XCTAssert(responseResult.count > 0)
    }

    func testGetLoadMoreListOfRepos()
    {
        
        let expectation = XCTestExpectation.init(description: "get repos List")
        var responseResult: [RepoItemModel]!
        sut.observableGithubRepoList.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(_):
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: disposeBag)
        sut.getReposWith(text: "john")
        
        wait(for: [expectation], timeout: 10)
        XCTAssert(responseResult.count > 0)
        sut.loadMoreRepos()
        XCTAssert(sut.offset == 2)
    }
    func testResetAllDataSources()
    {
        
        sut.refreshReposList()
        XCTAssert(sut.offset == 1)
    }

    func testRestUserName()
    {
        
        sut.clearReposList()
        XCTAssert(sut.userName.isEmpty)
    }
}
