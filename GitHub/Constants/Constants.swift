//
//  Constants.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class Constants {

    private static let baseUrl = "https://api.github.com/"
    public static let reposUsersApiUrl = baseUrl + "users/"
    public static let reposApiUrl = "/repos?page="

    public static let imagePlaceHolderName = "avatar"


    public static let appName = "appName"
    public static let internertConnectionDisconnected = "internertConnectionDisconnected"
    public static let internertConnectionReconnected = "internertConnectionReconnected"
    public static let githubScreenTitle = "githubScreenTitle"
    public static let noExisitingCashedData = "noExisitingCashedData"
    public static let noUsersWithName = "noUsersWithName"

    // MARK: access identifiers
    public static let tableViewIdentifier = "menuListTableView"
    public static let backButtonIdentifier = "backButton"
    public static let searchBarIdentifier = "searchBar"

    public static let repoTitleIdentifier = "repoTitle"
    public static let repoDateIdentifier = "repoDate"
    public static let repoDescIdentifier = "repoDesc"
    public static let repoOwnerImageIdentifier = "repoOwnerImage"
    public static let repoOwnerZoomedInImageIdentifier = "repoOwnerZoomedInImage"
    public static let repoForksIdentifier = "repoForks"
    public static let repoLanguageIdentifier = "repoLanguage"
    public static let repoLoadMoreIdentifier = "repoLoadMore"

    // MARK: DateFormats Constants
    public static let yearMonthDayFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    public static let shortMonthDayYearFormat = "MMM dd,yyyy"

}
