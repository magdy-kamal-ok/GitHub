//
//  GitHubGenericRequestTests.swift
//  GitHubTests
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
import Alamofire
@testable import GitHub

class GitHubGenericRequestTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUp() {

    }

    override func tearDown() {

    }

    func testSuccessRepoRequestClass()
    {
        let sut = GenericRequestClass<RepoItemModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        let offset = 1
        let expectation = XCTestExpectation.init(description: "test success Reposs request")
        var responseResult: [RepoItemModel]!
        var errorResponse: Error!
        let url = Constants.reposUsersApiUrl + "john" + Constants.reposApiUrl + "\(offset)"
        sut.callApi(url: url, params: nil, headers: headers)?.subscribe({ (subObj) in

            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }

        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
        XCTAssertNil(errorResponse)
    }

    func testFailureRepoRequestClass()
    {
        let sut = GenericRequestClass<RepoItemModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        let offset = 1
        let expectation = XCTestExpectation.init(description: "test success Reposs request")
        var responseResult: [RepoItemModel]!
        var errorResponse: Error!
        let url = "https://api.githubs.com/users/john" + Constants.reposApiUrl + "\(offset)"
        sut.callApi(url: url, params: nil, headers: headers)?.subscribe({ (subObj) in

            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }

        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(responseResult)
        XCTAssertNotNil(errorResponse)
    }


}
