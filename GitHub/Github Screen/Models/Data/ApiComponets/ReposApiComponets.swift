//
//  ReposApiComponets.swift
//  GitHub
//
//  Created by mac on 8/1/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct ReposApiComponets {
    var name:String = ""
    var offset:Int = 1
}
extension ReposApiComponets:ApiHeaders_Parametes_Url_Protocol
{
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
        var url = Constants.reposUsersApiUrl + self.name + Constants.reposApiUrl + "\(self.offset)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return url
    }
    
    func getParameterEncodeing() -> ParameterEncoding {
        return .json
    }
    
    
}
