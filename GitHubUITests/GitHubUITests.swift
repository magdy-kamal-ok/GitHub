//
//  GitHubUITests.swift
//  GitHubUITests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import GitHub

class GitHubUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testReposListLoaded() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let count = tableView.cells.count
        XCTAssert(count == 0)

    }

    func testRepoTableViewList() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: tableView) { () -> Bool in
            XCTAssert(tableView.cells.count == 30)
            return tableView.cells.count == 30
        }
        waitForExpectations(timeout: 10, handler: nil)


    }


    func testRepoOwnerImageExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoOwnerImage = firstCell.images[Constants.repoOwnerImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoOwnerImage, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }


    func testRepoTitleExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoTitle = firstCell.staticTexts[Constants.repoTitleIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRepoDateExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoDate = firstCell.staticTexts[Constants.repoDateIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoDate, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRepoDescExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoDesc = firstCell.staticTexts[Constants.repoDescIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoDesc, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRepoLanguageExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoLang = firstCell.staticTexts[Constants.repoLanguageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoLang, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRepoForksExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoFork = firstCell.staticTexts[Constants.repoForksIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoFork, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }




    func testReposZoomInImage() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoOwnerImage = firstCell.images[Constants.repoOwnerImageIdentifier]

        let zoomImage = app.images[Constants.repoOwnerZoomedInImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoOwnerImage) { () -> Bool in
            repoOwnerImage.tap()
            XCTAssert(zoomImage.exists)
            return zoomImage.exists
        }
        waitForExpectations(timeout: 10, handler: nil)

    }
    func testReposZoomInOutImage() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let repoOwnerImage = firstCell.images[Constants.repoOwnerImageIdentifier]

        let zoomImage = app.images[Constants.repoOwnerZoomedInImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: repoOwnerImage) { () -> Bool in
            repoOwnerImage.tap()
            zoomImage.tap()
            XCTAssert(repoOwnerImage.exists)
            return repoOwnerImage.exists
        }
        waitForExpectations(timeout: 10, handler: nil)
    }


    func testReposListPullRefresh() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("JohnSundell\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 5))
        start.press(forDuration: 0, thenDragTo: finish)
        _ = app.waitForExistence(timeout: 5)
        XCTAssert(tableView.cells.count == 30)

    }

}

