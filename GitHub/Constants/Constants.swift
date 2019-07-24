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
    public static let tagSectionTitle = "tagSectionTitle"
    public static let internertConnectionReconnected = "internertConnectionReconnected"
    public static let githubScreenTitle = "githubScreenTitle"
    public static let noExisitingCashedData = "noExisitingCashedData"

    // access identifiers
    public static let tableViewIdentifier = "menuListTableView"
    public static let backButtonIdentifier = "backButton"
    public static let searchBarIdentifier = "searchBar"
    

}
