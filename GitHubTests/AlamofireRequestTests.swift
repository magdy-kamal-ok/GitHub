//
//  AlamofireRequestTests.swift
//  GitHubTests
//
//  Created by mac on 8/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import GitHub

class AlamofireRequestTests: XCTestCase {

    let disposeBag = DisposeBag()
    override func setUp() {
        
    }

    override func tearDown() {
     
    }

    func testSuccessRepoRequestClass()
    {
        let sut = AlamofireRequestClass()
        let offset = 1
        let expectation = XCTestExpectation.init(description: "test success Reposs request")
        var responseResult: [RepoItemModel]!
        var errorResponse: Error!
        let repoApiComponents = ReposApiComponets.init(name: "john", offset: offset)

        sut.callApi(apiComponents: repoApiComponents)?.subscribe(
            onNext: {(responseObj:[RepoItemModel]) in
                responseResult = responseObj
                expectation.fulfill()
        },
            onError: {(error) in
                errorResponse = error
                expectation.fulfill()
        },
            onCompleted: {
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
        XCTAssertNil(errorResponse)
    }

    func testFailureRepoRequestClass()
    {
        let sut = AlamofireRequestClass()
        let offset = 1
        let expectation = XCTestExpectation.init(description: "test success Reposs request")
        var responseResult: [RepoItemModel]!
        var errorResponse: Error!
        let repoApiComponents = MockReposApiComponets.init(name: "john", offset: offset)
        
        sut.callApi(apiComponents: repoApiComponents)?.subscribe(
            onNext: {(responseObj:[RepoItemModel]) in
                responseResult = responseObj
                expectation.fulfill()
        },
            onError: {(error) in
                errorResponse = error
                expectation.fulfill()
        },
            onCompleted: {
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(responseResult)
        XCTAssertNotNil(errorResponse)
    }
    func testFakeRepoRequestClass()
    {
        let sut = FakeAlamofireRequest()
        let offset = 1
        let expectation = XCTestExpectation.init(description: "test success Reposs request")
        var responseResult: [RepoItemModel]!
        var errorResponse: Error!
        let repoApiComponents = MockReposApiComponets.init(name: "john", offset: offset)
        
        sut.callApi(apiComponents: repoApiComponents)?.subscribe(
            onNext: {(responseObj:[RepoItemModel]) in
                responseResult = responseObj
                expectation.fulfill()
        },
            onError: {(error) in
                errorResponse = error
                expectation.fulfill()
        },
            onCompleted: {
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(responseResult.count == 30)
        XCTAssertNil(errorResponse)
    }
    
    
}

struct MockReposApiComponets:ApiHeadersParametesUrlProtocol
{
    var name:String = ""
    var offset:Int = 1
    
    func getHeaders() -> [String : Any]? {
        let headers = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func getParameters() -> [String : Any]? {
        return nil
    }
    
    func getApiUrl() -> String {
        var url = "https://api.githubs.com/users/" + self.name + Constants.reposApiUrl + "\(self.offset)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return url
    }
    
    func getParameterEncodeing() -> ParameterEncoding {
        return .json
    }
    func getHttpMethod() -> String {
        return "GET"
    }
}

class FakeAlamofireRequest : GenericDataRemoteSource
{
    func callApi<R>(apiComponents: ApiHeadersParametesUrlProtocol) -> Observable<[R]>? where R : RemoteMappable {
        return Observable.create {
            observer in
            let repoBundle = Bundle(for: type(of: self))
        if let path = repoBundle.path(forResource: "Repos", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:Any]]{
                    var repoItems = [R]()
                    for item in jsonResult as[[String:Any]]
                    {
                        let itemObject = R(dict: item)!
                        repoItems.append(itemObject)
                    }
                    observer.onNext(repoItems)
                }
            } catch {
                let error = ErrorModel.init(desc: "error", code: 2000)
                observer.onError(error)
            }
        }
        
        return Disposables.create {
            
        }
        }
    }
    

    
}

