//
//  GitHubHelperDateFormatterTests.swift
//  GitHubTests
//
//  Created by mac on 7/25/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import GitHub

class GitHubHelperDateFormatterTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFormatStringFromDate()
    {
        let stringDate = "2018-07-28T00:00:00Z"
        let formatedDate = HelperDateFormatter.getDateFromString(dateString: stringDate, format: Constants.yearMonthDayFormat)
        XCTAssert(type(of: formatedDate) == Date.self)
    }
    
    func testFormatDateToShortMonthFormat()
    {
        let stringDate = "2019-03-22T00:00:00Z"
        let formatedDate = HelperDateFormatter.getDateFromString(dateString: stringDate, format: Constants.yearMonthDayFormat)
        let formatedDateString = HelperDateFormatter.formatDate(date: formatedDate, format: Constants.shortMonthDayYearFormat)
        XCTAssert(formatedDateString == "Mar 22,2019")
    }
    
}
